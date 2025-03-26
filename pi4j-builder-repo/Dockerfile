# ---------------------------------------------------------------------------------
# REPO BUILDER IMAGE FOR Pi4J (AARCH64)
# ---------------------------------------------------------------------------------
FROM ubuntu:22.04
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Pi4J "info@pi4j.com"

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="pi4j/pi4j-builder-repo"
LABEL org.label-schema.description="Pi4J Repo Builder Docker Image"
LABEL org.label-schema.url="https://pi4j.com/"
LABEL org.label-schema.vcs-url="https://github.com/pi4j/pi4j-docker"
LABEL org.label-schema.vendor="Pi4J"
LABEL org.label-schema.version=$BUILDVERSION
LABEL org.label-schema.docker.cmd="docker run --user \"$(id -u):$(id -g)\" -it --rm --volume $(pwd):/build pi4j/pi4j-builder-repo:latest"

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER Pi4J REPO BUILDER IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

# make sure APT packages are up to date and install build tools/utilities
RUN apt-get update && \
    apt-get install --yes apt-utils gnupg dpkg-dev nano file curl wget

# clean APT cache
RUN apt-get clean

# configure build time environment variables
ENV BUILD_FOLDER=/build
ENV PI4J_BUILDER="$BUILDVERSION"
ENV PI4J_BUILDER_DATE="$BUILDDATE"
ENV PI4J_BUILDER_ARCH="$TARGETARCH"

# set the working path to the build mounted volume
WORKDIR ${BUILD_FOLDER}

# always launch build script on container startup
ENTRYPOINT ["/bin/bash"]
