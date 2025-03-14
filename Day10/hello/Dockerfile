FROM registry.access.redhat.com/ubi8/openjdk-17 AS builder
RUN mkdir -p /home/jboss/myproject/target
WORKDIR /home/jboss/myproject
RUN mkdir -p /home/jboss/.m2
COPY . .
RUN mvn clean package

FROM registry.access.redhat.com/ubi8/openjdk-17
COPY --from=builder /home/jboss/myproject/target/hello-1.0.0.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar" ]
