# Stage 1: Build the Spring Boot JAR
FROM eclipse-temurin:17-jdk-focal AS builder

WORKDIR /app

# Copy Maven files
COPY pom.xml .

# Copy source code
COPY src ./src

# Package application
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Copy the built jar
COPY --from=builder /app/target/*.jar app.jar

# Expose the port (change if needed)
EXPOSE 9090

ENTRYPOINT ["java", "-jar", "app.jar"]
