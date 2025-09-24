# ---------------------------------------------------------------------------------
# NATIVE BUILDER IMAGE FOR Pi4J (cross-compilers for ARMHF & AARCH64)
# ---------------------------------------------------------------------------------
# To build locally for testing:
# docker build -t pi4j-builder-base \
#   --build-arg TARGETARCH=$(uname -m) \
#   --build-arg BUILDDATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
#   --build-arg BUILDVERSION=1.0.0
#   --progress=plain .
# ---------------------------------------------------------------------------------
FROM azul/zulu-openjdk:24-latest
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Pi4J "info@pi4j.com"

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

# Zulu OpenJDK (JDK) is installed because we started from an Ubuntu Zulu Docker image
# https://docs.azul.com/core/install/docker
# But we still need to configure the JAVA_HOME environment variable for Maven
ENV JAVA_HOME="/usr/lib/jvm/zulu24-ca-${TARGETARCH}"
RUN echo $JAVA_HOME
RUN ls -l $JAVA_HOME
RUN $JAVA_HOME/bin/java -version
RUN java -version

# install Apache Maven
ENV MAVEN_VERSION=3.9.11
ENV MAVEN_HOME=/opt/maven
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# Install Maven
RUN apt-get install -y curl tar && \
    curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xz -C /opt && \
    mv /opt/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    rm -rf /var/lib/apt/lists/*

# configure Maven with custom settings for defined M2 repository path
COPY maven-settings.xml /.m2/settings.xml
RUN mkdir -p /.m2/repository && chmod -R a+rw /.m2 && chmod -R g+s /.m2

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
