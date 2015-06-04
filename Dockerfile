FROM       sonatype/nexus
MAINTAINER Matt Jenkins <matt@helmetsrequired.org>

USER root

RUN echo "nexus.ui.keepAlive=false" >> \
  /opt/sonatype/nexus/conf/nexus.properties \
  && echo "shiro.globalSessionTimeout=600000" >> \
  /opt/sonatype/nexus/conf/nexus.properties

USER nexus
