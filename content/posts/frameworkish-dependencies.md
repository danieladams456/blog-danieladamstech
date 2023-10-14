---
title: "Framework-ish Dependencies"
date: 2023-10-12T20:18:02-04:00
tags: ["software engineering"]
draft: true
---

In software development, we generally must use dependencies to efficiently get more complex functionality we don't want to write ourselves. However, there are some types of dependencies that prove to be more painful when maintaining software than others. Less dependencies leads to less upgrade work including less security vulnerability remediation work. Below I rank categories of dependencies with respect to likelihood to have coupling issues during framework upgrades.

## The Dependencies

1. **Good:** broadly adopted, well-maintained dependencies that provide necessary functionality orthogonal to the framework (Spring Boot)
   - [AWS SDK](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/home.html), [MapStruct](https://mapstruct.org/), [JAXB](https://javaee.github.io/jaxb-v2/) used in another project
2. **Not ideal, but necessary:** coupled to the framework, but necessary functionality
   - [SpringFox](https://springfox.github.io/springfox/) for [OpenAPI spec](https://swagger.io/specification/) generation
3. **Probably not necessary:** small uses of convenience functions or premature optimizations
   - Pulling in the full [Apache Commons Collections](https://commons.apache.org/proper/commons-collections/) just for `CollectionUtils.isNotEmpty`, overriding to use [Apache HTTP client](https://hc.apache.org/index.html) instead of the Spring Boot default for a low-traffic service
4. **Bad:** tightly coupled to the framework but not officially supported by the framework team
   - [Derjust Spring Data DynamoDB](https://github.com/derjust/spring-data-dynamodb) stopped being maintained but required major code reorganization to remove.

## The Story

I was upgrading a small service that persisted configuration data in DynamoDB and called a couple upstream APIs. It was developed and deployed to prod, but never fully adopted. A couple of years later, there were new requirements and changes needed to make it usable. Upgrading this service gave me an ah-ha moment regarding types of dependencies and the level of upgrade risk they bring with them. After glancing at the original state of the service, here were my goals: Upgrade Spring Boot 2.0.6 to 3.1.x, Java 8 to 17, remove unofficial [spring-data-dynamodb.](https://github.com/derjust/spring-data-dynamodb), and upgrade AWS Java SDK v1 to v2. There wasn't any issue with AWS SDK v1, but I wanted some experience with v2 since that's what we'll be using for net-new services.

Only after I had started bumping Spring Boot versions did I realize that the unofficial Spring Boot DynamoDB dependency was last released January of 2019 (four and a half years ago.) That release only supported up to Spring Boot 2.1. [Spring Boot 2.5](https://docs.spring.io/spring-boot/docs/2.5.x/reference/html/getting-started.html#getting-started.system-requirements) was the first release to support Java 17. The upgrade path would have had to be remove Spring Data DynamoDB, upgrade to Spring Boot 2.5, Java 17, Spring Boot 3.1. Along the way would have been a Junit 4 to 5 migration and SpringFox to [SpringDoc.](https://springdoc.org/) The code had a good bit of extra dependencies, boilerplate copy/paste servlet filters and loggers, etc. All those together lead me to write a minimal service from scratch on Spring Boot 3.1 and Java 17.

I utilized MapStruct to map between the API data format shared properties + overrides by and the denormalized set of records in DynamoDB. I wanted to do as much as possible with immutable Java records instead of Lombok-annotated data classes. The DynamoDB enhanced client came through and was compatible with Records following the same pattern [this documentation](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/ddb-en-client-use-immut.html) shows with classes.

## The Code

### DynamoDB mapper immutable entity

```java
@DynamoDbImmutable(builder = DemoEntity.DemoEntityBuilder.class)
@Builder(toBuilder = true)
public record DemoEntity(
    // keys and special DynamoDB attributes
    @DynamoDbPartitionKey
    String pk,
    @DynamoDbSortKey
    String sk,
    @DynamoDbVersionAttribute
    Long version, // record level lock

    // record attributes
    String shared_attribute_one,
    String shared_attribute_two,
    String shared_attribute_three,
    String override_attribute_one,
    String override_attribute_two
) {
}
```

### DTO to entity mapper

```java
@Mapper(componentModel = "spring")
public interface RootMapper {
    /**
     * Singleton mapper, combine root level parameters with leaf level parameters.
     */
    // keys
    @Mapping(source = "root.id", target = "pk")
    @Mapping(expression = "java(\"SORT_KEY_PREFIX#\" + leaf.leafType())", target = "sk")
    // root level attributes
    @Mapping(source = "root.sharedAttributeOne", target = "shared_attribute_one")
    @Mapping(source = "root.sharedAttributeTwo", target = "shared_attribute_two")
    @Mapping(source = "root.sharedAttributeThree", target = "shared_attribute_three")
    // leaf level attributes
    @Mapping(source = "leaf.overrideAttributeOne", target = "override_attribute_one")
    @Mapping(source = "leaf.overrideAttributeTwo", target = "override_attribute_two")
    DemoEntity dtoToEntitySingle(Root root, Leaf leaf);


    /**
     * Combine the root level parameters with leaf level parameters.
     * Pass combo to MapStruct mapper that just has to worry about the singleton case.
     */
    default List<DemoEntity> dtoToEntityList(Root root) {
        return root.leaves().stream()
                .map(leaf -> dtoToEntitySingle(root, leaf))
                .toList();
    }
}
```
