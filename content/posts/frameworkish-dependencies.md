---
title: "Framework-ish Dependencies"
date: 2023-10-12T20:18:02-04:00
tags: ["software engineering"]
draft: true
---

In software development, we generally must use dependencies to get anything useful accomplished. However, there are some types of dependencies that prove to be more painful when maintaining software than others. Coming from a security background and especially now using software composition analysis tools on my codebases makes me aware of and want to minimize dependency sprawl. The less dependencies, the less frequently your app will get flagged with some critical security vulnerabilities that you will have to go back and address.

These dependencies are listed in the context of a Spring Boot rest API.

## The Dependencies

1. Good: broadly adopted dependencies that provide necessary functionality orthogonal to the framework
   - AWS SDK, MapStruct, JAXB (used in another project)
2. Not ideal, but necessary: coupled to the framework, but necessary functionality
   - SpringFox for OpenAPI spec generation
3. Probably not necessary: small uses of convenience functions or premature optimizations
   - Pulling in Apache commons collections just for `CollectionUtils.isNotEmpty`, overriding Apache HTTP client instead of using the Spring Boot default for a low-traffic service.
4. Bad: tightly coupled to framework but not officially supported by the framework team
   - [derjust Spring Data DynamoDB](https://github.com/derjust/spring-data-dynamodb)

## The Story

I was upgrading a small service that persisted configuration data in DynamoDB and called a couple upstream APIs. It had never quite gone to prod, and a couple of years later there were some requirements changes we needed to implement to get it usable. Upgrading this service gave me an ah-ha moment regarding types of dependencies and the level of upgrade risk they bring with them. After glancing at the original state of the service, here were my goals: Upgrade Spring Boot 2.0.6 to 3.1.x, Java 8 to 17, remove unofficial [spring-data-dynamodb.](https://github.com/derjust/spring-data-dynamodb), and upgrade AWS Java SDK v1 to v2. There wasn't any issue with v1, but I wanted some experience with v2 since that's what we'll be using for net-new services.

Only after I had started bumping Spring Boot versions did I realize that the unofficial Spring Boot DynamoDB dependency was last released January of 2019 (four and a half years ago.) That release only supported up to Spring Boot 2.1. [Spring Boot 2.5](https://docs.spring.io/spring-boot/docs/2.5.x/reference/html/getting-started.html#getting-started.system-requirements) was the first release to support Java 17. The upgrade path would have had to be remove Spring Data DynamoDB, upgrade to Spring Boot 2.5, Java 17, Spring Boot 3.1. Along the way would have been a Junit 4 to 5. The code had a good bit of extra dependencies, boilerplate servlet filters and loggers, etc. All those together lead me to write a minimal service from scratch on Spring Boot 3.1 and Java 17. I also realized to move to Spring Boot 3, I would have to switch out SpringFox for SpringDoc.

I utilized MapStruct to map between the API data format shared properties + overrides by and the denormalized set of records in DynamoDB. I wanted to do as much as possible with immutable Java records instead of Lombok-annotated data classes. The DynamoDB enhanced client came through and was compatible with Records following the same pattern [this documentation](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/ddb-en-client-use-immut.html) shows with classes.

## The Code

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
    String attribute_one,
    String attribute_two
) {
}
```
