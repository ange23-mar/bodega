FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
USER root
RUN mkdir -p /etc/secrets
COPY --from=build /app/target/*.jar app.jar
RUN printf '#!/bin/sh\n\
if [ ! -z "$WALLET_BASE64" ]; then\n\
    echo "$WALLET_BASE64" | base64 -d > /etc/secrets/cwallet.sso\n\
fi\n\
if [ ! -z "$ORACLE_TNSNAMES" ]; then\n\
    printf "%s" "$ORACLE_TNSNAMES" > /etc/secrets/tnsnames.ora\n\
fi\n\
if [ ! -z "$ORACLE_SQLNET" ]; then\n\
    printf "%s" "$ORACLE_SQLNET" > /etc/secrets/sqlnet.ora\n\
fi\n\
exec java $JAVA_OPTS -jar app.jar\n' > /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
EXPOSE 8085
ENTRYPOINT ["/app/entrypoint.sh"]