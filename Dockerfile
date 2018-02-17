FROM kster/8-jdk-alpine:0.0.1
VOLUME /tmp
ADD target/fileManager-0.0.1.jar app.jar
ENV JAVA_OPTS="-Xmx300m"
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar -Dspring.profiles.active=prd /app.jar
