# ---------------------------------------------------------------------------------
# NATIVE BUILDER IMAGE FOR Pi4J (cross-compilers for ARMHF & AARCH64)
# ---------------------------------------------------------------------------------
FROM ubuntu:22.04
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Robert Savage "robert@pi4j.com"

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="pi4j/pi4j-builder-base"
LABEL org.label-schema.description="Pi4J Base Builder Docker Image"
LABEL org.label-schema.url="https://pi4j.com/"
LABEL org.label-schema.vcs-url="https://github.com/pi4j/pi4j-docker"
LABEL org.label-schema.vendor="Pi4J"
LABEL org.label-schema.version=$BUILDVERSION
LABEL org.label-schema.docker.cmd="docker run --user \"$(id -u):$(id -g)\" -it --rm --volume $(pwd):/build pi4j/pi4j-builder-base:latest"

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER Pi4J BASE BUILDER IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

# make sure APT packages are up to date and install apt utilities
RUN apt-get update && \
    apt-get install --yes apt-utils

# install additional build tools and utilities
RUN apt-get install --yes git build-essential tree nano file curl wget autoconf autoconf-archive libtool pkg-config

# install OpenJDK 21 (JDK) and configure JAVA_HOME environment variable
RUN apt-get install --yes openjdk-21-jdk-headless
ENV JAVA_HOME="/usr/lib/jvm/java-21-openjdk-$TARGETARCH/"

# install Apache Maven
RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh"
RUN sdk install maven 3.9.4
RUN sdk use maven 3.9.4

# configure Maven with custom settings for defined M2 repository path
COPY maven-settings.xml /usr/share/maven/conf/settings.xml
RUN mkdir -p /m2/repository && chmod -R a+rw /m2 && chmod -R g+s /m2

# clean APT cache
RUN apt-get clean

# validate installed versions
RUN java -version
RUN mvn -v

# configure build time environment variables
ENV BUILD_FOLDER=/build
ENV PI4J_BUILDER="$BUILDVERSION"
ENV PI4J_BUILDER_DATE="$BUILDDATE"
ENV PI4J_BUILDER_ARCH="$TARGETARCH"

# set the working path to the build mounted volume
WORKDIR ${BUILD_FOLDER}

# always launch build script on container startup
ENTRYPOINT ["/bin/bash"]
