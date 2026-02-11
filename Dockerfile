# Stage 1: Build the Spring Boot application
FROM eclipse-temurin:17-jdk-focal AS builder

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the Spring Boot application JAR (skip tests to speed up)
RUN mvn clean package -DskipTests

# Stage 2: Create the lightweight runtime image
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Copy the JAR built in the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port your app listens on
EXPOSE 9090

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
