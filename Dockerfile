# Use OpenJDK 21 as base image
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy the JAR file from target directory
COPY target/*.jar app.jar

# Change ownership to non-root user
RUN chown appuser:appuser app.jar

# Switch to non-root user
USER appuser

# Expose port 8080 (default Spring Boot port)
EXPOSE 8080

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Set JVM options for containerized environment
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom"

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
