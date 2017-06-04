FROM alpine:3.6

MAINTAINER aron@aron.nu
COPY ./startup.jsh /tmp/
ENV VAVR=0.9.0
ENV JAVA_HOME=/usr/lib/jvm/jdk-9 BUILD=171 PATH=${PATH}:${JAVA_HOME}/bin
RUN mkdir -p ${JAVA_HOME} && apk add --update curl ca-certificates && curl https://repo1.maven.org/maven2/io/vavr/vavr/${VAVR}/vavr-${VAVR}.jar -o /tmp/vavr.jar
RUN cd ${JAVA_HOME} && curl http://download.java.net/java/jdk9/archive/${BUILD}/binaries/jdk-9-ea+${BUILD}_linux-x64-musl_bin.tar.gz | tar xz
RUN ln -s ${JAVA_HOME}/bin/java /usr/bin/java && ln -s ${JAVA_HOME}/bin/javac /usr/bin/javac && ln -s ${JAVA_HOME}/bin/jshell /usr/bin/jshell
RUN rm -rf $JAVA_HOME/lib/src.zip $JAVA_HOME/jmods/java.corba.jmod $JAVA_HOME/jmods/java.desktop.jmod $JAVA_HOME/jmods/java.smartcardio.jmod
RUN apk del wget ca-certificates && rm /var/cache/apk/*

ENTRYPOINT ["/usr/bin/jshell", "--class-path", "/tmp/vavr.jar", "--startup", "/tmp/startup.jsh"]
