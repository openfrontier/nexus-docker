#!/bin/bash
set -e

NEXUS_PLUGIN_PATH=${SONATYPE_WORK}/plugin-repository
P2_PLUGIN_PATH=/opt/sonatype/nexus
P2_BRIDGE_PLUGIN=nexus-p2-bridge-plugin-${NEXUS_VERSION}
P2_REPO_PLUGIN=nexus-p2-repository-plugin-${NEXUS_VERSION}

echo "Setup p2 plugins."
rm -f ${NEXUS_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN}
rm -f ${NEXUS_PLUGIN_PATH}/${P2_REPO_PLUGIN}
ln -s ${P2_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN} ${NEXUS_PLUGIN_PATH}/${P2_BRIDGE_PLUGIN}
ln -s ${P2_PLUGIN_PATH}/${P2_REPO_PLUGIN}   ${NEXUS_PLUGIN_PATH}/${P2_REPO_PLUGIN}

echo "Start up nexus."
exec java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF} 
