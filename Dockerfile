FROM sonatype/nexus:2.11.2

ENV WEBAPP_CONTEXT_PATH=/nexus

CMD java \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  ${JAVA_OPTS} \
  -Dnexus-work=/sonatype-work -Dnexus-webapp-context-path=${WEBAPP_CONTEXT_PATH} \
  -cp conf/:`(echo lib/*.jar) | sed -e "s/ /:/g"` \
  org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml
