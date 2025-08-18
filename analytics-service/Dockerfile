FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:21-jdk AS runner

WORKDIR /app

COPY --from=builder ./app/target/analytics-service-0.0.1-SNAPSHOT.jar ./app.jar
# Enable debug on port 5005
ENV JAVA_TOOL_OPTIONS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"


EXPOSE 4002
ENTRYPOINT ["java", "-jar", "app.jar"]