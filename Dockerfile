FROM alpine:3.6

MAINTAINER aron@aron.nu
COPY ./startup.jsh /tmp/
COPY ./entrypoint.sh /tmp/
ENV VAVR=0.9.0
ENV JAVA_HOME=/usr/lib/jvm/jdk-9 BUILD=171 PATH=${PATH}:${JAVA_HOME}/bin
RUN apk add --update wget ca-certificates
    
RUN wget https://repo1.maven.org/maven2/io/vavr/vavr/${VAVR}/vavr-${VAVR}.jar -O /tmp/vavr.jar
RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.java.net/java/jdk9/archive/${BUILD}/binaries/jdk-9-ea+${BUILD}_linux-x64-musl_bin.tar.gz -O /tmp/jdk-9.tar.gz
RUN mkdir -p ${JAVA_HOME}
RUN tar xf /tmp/jdk-9.tar.gz -C /usr/lib/jvm
RUN ln -s ${JAVA_HOME}/bin/java /usr/bin/java
RUN ln -s ${JAVA_HOME}/bin/javac /usr/bin/javac
RUN ln -s ${JAVA_HOME}/bin/jshell /usr/bin/jshell
 RUN rm -rf \
   $JAVA_HOME/lib/src.zip \
   $JAVA_HOME/jmods/java.corba.jmod \
   $JAVA_HOME/jmods/java.desktop.jmod \
   $JAVA_HOME/jmods/java.smartcardio.jmod 

RUN apk del wget ca-certificates
RUN rm /var/cache/apk/* /tmp/jdk-9.tar.gz

ENTRYPOINT ["/usr/bin/jshell", "--class-path", "/tmp/vavr.jar", "--startup", "/tmp/startup.jsh"]
