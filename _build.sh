#!/bin/bash

IMAGENAME_LABEL=docsify/air-gapped
IMAGEFILE="docsify.v4.13.tar"

# Set up log
LOG="docker_build_$(date +%Y%m%d_%H%M%S).log"
echo ""
echo "Building image; output printed to ${LOG}."
echo ""

echo "" >> ${LOG}
echo $(date) >> ${LOG}
echo $(docker --version) >> ${LOG}
echo "==================================================" >> ${LOG}
echo "" >> ${LOG}


# Build image
docker build -f dockerfile -t ${IMAGENAME_LABEL} . >> ${LOG} 2>&1

echo "The image ${IMAGENAME_LABEL} is built."
echo "Check \"${LOG}\" for build-details."
echo "Run \"docker image inspect ${IMAGENAME_LABEL}\" for image-details."
echo ""
echo ""

# Save image
echo "Saving the image to disk"
docker save "${IMAGENAME_LABEL}" -o "${IMAGEFILE}"
echo "The image ${IMAGENAME_LABEL} is saved to file: ${IMAGEFILE}."

echo ""
echo "Done!"
echo ""