FROM alpine:3.7

MAINTAINER aron@aron.nu
COPY ./vavr.jar ./startup.jsh /tmp/
ADD jre /opt/jre
ADD mods /opt/lib
ENV JAVA_HOME=/opt/jre
ENV PATH=$PATH:$JAVA_HOME/bin
CMD ["jshell", "--class-path", "/tmp/vavr.jar", "--startup", "/tmp/startup.jsh"]
