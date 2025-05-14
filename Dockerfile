# Use Maven to build the application
FROM maven:3.8.7-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime for the final image
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.war app.war
ENTRYPOINT ["java", "-war", "app.war"]
