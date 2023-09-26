# Ideas list

1. Kotlin
2. [Book notes](https://github.com/mgp/book-notes/tree/master)
3. When using dependencies in conjunction with a framework, try to either stay inside the framework or completely orthogonal to it. Otherwise the dependencies will be coupled to framework version and require constant coordination on upgrades.
   1. Good: Spring Boot + JAXB for XML marshalling
   2. Bad: Spring boot with [unofficial DynamoDB mapper](https://github.com/derjust/spring-data-dynamodb)
   3. Not ideal but necessary: [SpringFox for OpenAPI documentation](https://github.com/springfox/springfox), now need to migrate to [SpringDoc](https://springdoc.org/)
   4. Not ideal, probably don't want to override the default HTTP client unless you're doing real performance tuning: `org.apache.httpcomponents:httpclient`

# Logo

```
- *
-*-*
****
```
