FROM alpine:3.6

MAINTAINER aron@aron.nu
COPY ./startup.jsh /tmp/
ADD jre /opt/jre
ADD mods /opt/lib
ENV JAVA_HOME=/opt/jre VAVR=0.9.1
ENV PATH=$PATH:$JAVA_HOME/bin
RUN apk add --update curl ca-certificates && \
    curl https://repo1.maven.org/maven2/io/vavr/vavr/${VAVR}/vavr-${VAVR}.jar -o /tmp/vavr.jar && \
    apk del wget ca-certificates && rm /var/cache/apk/*
CMD ["jshell", "--class-path", "/tmp/vavr.jar", "--startup", "/tmp/startup.jsh"]
