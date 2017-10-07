# Java repl with preloaded vavr.io

Java 9

Alpine Linux

~ 270MB

https://hub.docker.com/r/andreasaronsson/jshell-vavr-alpine/

`docker run -it --rm andreasaronsson/jshell-vavr-alpine`



FROM alpine:3.6
ADD ajre /opt/jre
ADD lib /opt/lib
ENV JAVA_HOME=/opt/jre
ENV PATH=$PATH:$JAVA_HOME/bin
CMD ["java", "-classpath", "/opt/lib/???.jar", "???.Main"]


/usr/lib/jvm/java-9-jdk/bin/javac -d ./mods/nu.aron.vavrjshell ./src/nu.aron.vavrjshell/module-info.java ./src/nu.aron.vavrjshell/nu/aron/vavrjshell/Main.java
