FROM docker.io/alpine:latest AS jlink

LABEL maintainer="aron@aron.nu"

RUN apk add binutils
# ADD https://download.java.net/java/early_access/alpine/12/binaries/openjdk-14-ea+12_linux-x64-musl_bin.tar.gz /tmp/jdk.tar.gz
ADD https://aron.nu/14.tar.gz /tmp/jdk.tar.gz
RUN tar xf /tmp/jdk.tar.gz -C /opt
COPY ./src /opt

RUN ["/opt/jdk-14/bin/javac", "-d", "/opt/mods/nu.aron.vavrjshell", \ 
    "/opt/nu.aron.vavrjshell/module-info.java",  "/opt/nu.aron.vavrjshell/nu/aron/vavrjshell/Main.java"]

RUN ["/opt/jdk-14/bin/jlink", "--compress=2", "--no-header-files", "--no-man-pages", "--strip-debug", \
     "--module-path", "/opt/jdk-14/jmods:/opt/mods", \
     "--add-modules", "nu.aron.vavrjshell", "--output", "/jlinked"]

FROM alpine:latest
COPY --from=jlink /jlinked /opt/jdk/
COPY ./startup.jsh /opt
ADD https://repo1.maven.org/maven2/io/vavr/vavr/0.10.2/vavr-0.10.2.jar /opt
CMD ["/opt/jdk/bin/jshell", "--class-path", "/opt/vavr-0.10.2.jar", "--startup", "/opt/startup.jsh"]
