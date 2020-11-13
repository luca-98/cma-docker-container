### STAGE 1: Build ###
FROM maven:3.6.3-openjdk-11-slim AS build

RUN mkdir /code
WORKDIR /code

COPY cma-server/pom.xml /code/pom.xml
RUN mvn dependency:go-offline

COPY cma-server/. /code
RUN mvn install -Dmaven.test.skip=true

### STAGE 2: Run ###
FROM openjdk:11.0.8-jdk-slim

RUN apt-get update; apt-get install -y fontconfig libfreetype6

ENV TZ Asia/Ho_Chi_Minh

COPY --from=build /code/target/*.jar /usr/local/lib/app.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]