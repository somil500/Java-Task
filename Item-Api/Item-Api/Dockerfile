# Stage 1: Build stage using Maven
FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /app

# 1. Copy only the pom.xml first to fetch dependencies
# This creates a cached layer so you don't re-download the internet on every code change
COPY pom.xml .
RUN mvn dependency:go-offline -B

# 2. Copy the source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image (Lightweight JRE)
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Copy the built jar from builder stage
# Note: It's safer to use the specific name if you know it, or keep the wildcard
COPY --from=builder /app/target/*.jar app.jar

# Expose the port
EXPOSE 9090

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
