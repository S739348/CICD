# Use an official Maven image with Java 21 to build the application
FROM maven:3.9.5-openjdk-21-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime as a parent image for the runtime stage
FROM openjdk:21-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage and rename it to CICD.jar
COPY --from=build /app/target/*.jar CICD.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "CICD.jar"]
