#!/bin/bash
set -e

NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}
NEXUS_IMAGE_NAME=${NEXUS_IMAGE_NAME:-openfrontier/nexus}

# Stop and delete nexus container.
if [ -z "$(docker ps -a | grep ${NEXUS_VOLUME})" ]; then
  echo "${NEXUS_VOLUME} does not exist."
  exit 1
elif [ -n "$(docker ps -a | grep ${NEXUS_NAME} | grep -v ${NEXUS_VOLUME})" ]; then
  docker stop ${NEXUS_NAME}
  docker rm ${NEXUS_NAME}
fi

# Start Nexus.
docker run \
--name ${NEXUS_NAME} \
-p 8081:8081 \
--volumes-from ${NEXUS_VOLUME} \
-e CONTEXT_PATH=/nexus \
-d ${NEXUS_IMAGE_NAME}
