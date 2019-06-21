FROM sonatype/nexus:2.14.13-01

MAINTAINER zsx <thinkernel@gmail.com>

ENV NEXUS_VERSION 2.14.10-01
ENV MAX_HEAP 1792m
ENV MIN_HEAP 1024m

USER root

RUN yum install -y \
  unzip \
  && yum clean all

ARG DOWNLOAD_SITE=https://repo.maven.apache.org/maven2/org/sonatype/nexus/plugins

RUN echo "Downloading: ${DOWNLOAD_SITE}/nexus-p2-repository-plugin/${NEXUS_VERSION}/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip" && \
    curl -fSsL ${DOWNLOAD_SITE}/nexus-p2-repository-plugin/${NEXUS_VERSION}/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip \
         -o /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip && \
    unzip -q     /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip && \
    chmod -R 755 /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION} && \
    rm /opt/sonatype/nexus/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip

RUN echo "Downloading: ${DOWNLOAD_SITE}/nexus-p2-bridge-plugin/${NEXUS_VERSION}/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip" && \
    curl -fSsL ${DOWNLOAD_SITE}/nexus-p2-bridge-plugin/${NEXUS_VERSION}/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip \
         -o /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip && \
    unzip -q     /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip && \
    chmod -R 755 /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION} && \
    rm /opt/sonatype/nexus/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip

COPY nexus-start.sh /usr/local/bin/nexus-start.sh

USER nexus

CMD ["/usr/local/bin/nexus-start.sh"]
