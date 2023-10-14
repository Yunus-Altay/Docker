FROM maven:3.9.4-eclipse-temurin-8-alpine AS builder
COPY /myproject /app
WORKDIR /app
RUN mvn clean package

FROM openjdk:11-jre-slim
WORKDIR /myapp
COPY --from=builder /app/target/myproject-1.0-SNAPSHOT-jar-with-dependencies.jar /myapp/app.jar
CMD ["java", "-jar", "app.jar"]