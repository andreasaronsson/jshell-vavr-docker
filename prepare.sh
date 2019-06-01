#!/bin/bash

VAVR=0.9.2
URL=https://download.java.net/java/early_access/alpine/11/binaries/openjdk-11-ea+11_linux-x64-musl_bin.tar.gz
curl $URL | tar xz

/usr/lib/jvm/java-10-openjdk-10.0.1.10-3.fc28.x86_64/bin/javac -d ./mods/nu.aron.vavrjshell ./src/nu.aron.vavrjshell/module-info.java ./src/nu.aron.vavrjshell/nu/aron/vavrjshell/Main.java
/usr/lib/jvm/java-10-openjdk-10.0.1.10-3.fc28.x86_64/bin/jlink --module-path lib:jdk-11/jmods:./mods --output jre --add-modules nu.aron.vavrjshell --limit-modules nu.aron.vavrjshell --compress 2 --no-header-files --no-man-pages --strip-debug
curl https://repo1.maven.org/maven2/io/vavr/vavr/${VAVR}/vavr-${VAVR}.jar -o vavr.jar

docker build .
