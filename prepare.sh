#!/bin/bash

VAVR=0.9.1
URL=http://download.java.net/java/jdk9-alpine/archive/181/binaries/jdk-9-ea+181_linux-x64-musl_bin.tar.gz
curl $URL | tar xz

/usr/lib/jvm/java-9-jdk/bin/javac -d ./mods/nu.aron.vavrjshell ./src/nu.aron.vavrjshell/module-info.java ./src/nu.aron.vavrjshell/nu/aron/vavrjshell/Main.java
/usr/lib/jvm/java-9-jdk/bin/jlink --module-path lib:jdk-9/jmods:./mods --output jre --add-modules nu.aron.vavrjshell --limit-modules nu.aron.vavrjshell --compress 2 --no-header-files --no-man-pages --strip-debug
curl https://repo1.maven.org/maven2/io/vavr/vavr/${VAVR}/vavr-${VAVR}.jar -o vavr.jar

docker build .
