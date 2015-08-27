FROM sonatype/nexus:oss

MAINTAINER zsx <thinkernel@gmail.com>

ENV MAX_HEAP 2048m
ENV MIN_HEAP 512m

USER root

RUN yum install -y \
  unzip \
  && yum clean all

RUN curl -L http://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-p2-repository-plugin/${NEXUS_VERSION}/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip -o /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip && \
    unzip -q /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip && \
    rm /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip

RUN curl -L http://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-p2-bridge-plugin/${NEXUS_VERSION}/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip -o /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip && \
    unzip -q /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip && \
    rm /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip

COPY nexus-start.sh /usr/local/bin/nexus-start.sh

USER nexus

CMD ["/usr/local/bin/nexus-start.sh"]
