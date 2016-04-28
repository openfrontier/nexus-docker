#!/bin/bash
set -e
NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}
NEXUS_IMAGE_NAME=${NEXUS_IMAGE_NAME:-openfrontier/nexus}
CI_NETWORK=${CI_NETWORK:-ci-network}

#Create nexus volume.
if [ -z "$(docker ps -a | grep ${NEXUS_VOLUME})" ]; then
    docker run \
    --name ${NEXUS_VOLUME} \
    ${NEXUS_IMAGE_NAME} \
    echo "Create nexus volume."
fi

#Start nexus
docker run \
--name ${NEXUS_NAME} \
--net ${CI_NETWORK} \
--volumes-from ${NEXUS_VOLUME} \
-e CONTEXT_PATH=/nexus \
-d ${NEXUS_IMAGE_NAME}
