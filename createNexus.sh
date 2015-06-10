#!/bin/bash
set -e
NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}
NEXUS_IMAGE_NAME=${NEXUS_IMAGE_NAME:-sonatype/nexus}

#Create nexus volume.
docker run \
--name ${NEXUS_VOLUME} \
${NEXUS_IMAGE_NAME} \
echo "Create nexus volume."

#Start nexus
docker run \
--name ${NEXUS_NAME} \
-p 8081:8081 \
--volumes-from ${NEXUS_VOLUME} \
-e CONTEXT_PATH=/nexus \
-d ${NEXUS_IMAGE_NAME}
