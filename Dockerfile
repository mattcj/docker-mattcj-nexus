FROM       dockerfile/java:oracle-java7
MAINTAINER Matt Jenkins <matt@helmetsrequired.org>

# The version of nexus to install
ENV NEXUS_VERSION 2.11.2-06

RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | gunzip \
  | tar x -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION}

RUN useradd -r -u 200 -m -c "nexus role account" -d /sonatype-work -s /bin/false nexus

VOLUME /sonatype-work

EXPOSE 8081
USER nexus
WORKDIR /opt/sonatype/nexus
ENV MAX_HEAP 1g
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true

# these lines below added by mattcj
ENV WEBAPP_CONTEXT_PATH=/nexus

CMD java \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  ${JAVA_OPTS} \
  -Dnexus-work=/sonatype-work -Dnexus-webapp-context-path=${WEBAPP_CONTEXT_PATH} \
  -cp conf/:`(echo lib/*.jar) | sed -e "s/ /:/g"` \
  org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml
