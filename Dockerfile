# Development Dockerfile with Live Reload using entr
FROM maven:3.9-eclipse-temurin-21

WORKDIR /app

# Install entr
RUN apt-get update && apt-get install -y entr

# Copy pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the rest of the application source code
COPY . .

# Expose the application port
EXPOSE 8080

# Run the application with live reload using entr
CMD ["/bin/sh", "-c", "find src -name '*.java' | entr -nr mvn spring-boot:run"]