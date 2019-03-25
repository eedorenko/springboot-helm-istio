FROM gradle:jdk8 as builder


COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build


FROM openjdk:8-jre
EXPOSE 8080 5005
COPY --from=builder /home/gradle/src/build/libs/* /opt/target/
WORKDIR /opt/target
ENV _JAVA_OPTIONS '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005'

CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]