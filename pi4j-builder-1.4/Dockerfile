# ---------------------------------------------------------------------------------
# NATIVE BUILDER IMAGE FOR Pi4J (cross-compilers for ARMHF & AARCH64)
# ---------------------------------------------------------------------------------
FROM pi4j/pi4j-builder-native:1.4
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Robert Savage "robert@pi4j.com"

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="pi4j/pi4j-builder"
LABEL org.label-schema.description="Pi4J Builder Docker Image (for Pi4J v$BUILDVERSION)"
LABEL org.label-schema.url="https://pi4j.com/"
LABEL org.label-schema.vcs-url="https://github.com/pi4j/pi4j-docker"
LABEL org.label-schema.vendor="Pi4J"
LABEL org.label-schema.version=$BUILDVERSION
LABEL org.label-schema.docker.cmd="docker run --user \"$(id -u):$(id -g)\" --rm --volume $(pwd):/build pi4j/pi4j-builder:$BUILDVERSION"

RUN echo "========================================================="
RUN echo "  BUILDING DOCKER Pi4J v$BUILDVERSION BUILDER IMAGE FOR: $TARGETARCH"
RUN echo "========================================================="

# ---------------------------------------------------------------------------------
# PROJECT BUILDER IMAGE FOR Pi4J v1.4
# ---------------------------------------------------------------------------------
# we want to locally cache all build dependencies to speed up build-time,
# so we will clone the Pi4J project from GitHub and perform a download
# of all Maven build plugins and dependencies.  When complete we will
# simply delete the project sources from the image and leave the M2
# repository cache as part of the container image
RUN git clone --single-branch --branch develop/1.4 https://github.com/Pi4J/pi4j /pi4j
RUN cd /pi4j && \
    mvn dependency:resolve dependency:resolve-plugins -DexcludeGroupIds="com.pi4j" -Pnative && \
    rm -R /pi4j

# ensure read/write access permissions to the M2 repository cache for all users
RUN chmod -R a+rw /m2

# configure environment variables
ENV PI4J_BUILDER_DATE="$BUILDDATE"
ENV PI4J_BUILDER="$BUILDVERSION"

# always launch Maven to perform the build
ENTRYPOINT ["/usr/bin/mvn"]

# use these default parameters for the Maven build; can be overridden by caller
CMD ["clean", "install", "-DskipTests", "-Pnative,cross-compile"]
