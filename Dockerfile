#
# Build stage
#
FROM maven:3-eclipse-temurin-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package
#
# Package stage
#
FROM amazoncorretto:17-alpine3.14
COPY --from=build /home/app/target/hello-spring-0.0.1-SNAPSHOT.jar /usr/local/lib/hello-spring.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/hello-spring.jar"]
