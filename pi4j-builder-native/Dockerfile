# ---------------------------------------------------------------------------------
# NATIVE BUILDER IMAGE FOR Pi4J (cross-compilers for ARMHF & AARCH64)
# ---------------------------------------------------------------------------------
FROM pi4j/pi4j-builder-base:latest
ARG TARGETARCH
ARG BUILDDATE
ARG BUILDVERSION
MAINTAINER Robert Savage "robert@pi4j.com"

# docker container image labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILDDATE
LABEL org.label-schema.name="pi4j/pi4j-builder-native"
LABEL org.label-schema.description="Pi4J Native Builder Docker Image"
LABEL org.label-schema.url="https://pi4j.com/"
LABEL org.label-schema.vcs-url="https://github.com/pi4j/pi4j-docker"
LABEL org.label-schema.vendor="Pi4J"
LABEL org.label-schema.version=$BUILDVERSION
LABEL org.label-schema.docker.cmd="docker run --user \"$(id -u):$(id -g)\" --rm --volume $(pwd):/build pi4j/pi4j-builder-native:$BUILDVERSION"

# make sure APT packages are up to date
RUN apt-get update

# install ARM cross compiler toolchains for 32-bit ARM
#RUN apt-get install --yes gcc-arm-linux-gnueabi

# install ARM cross compiler toolchains for 32-bit ARMHF
#RUN apt-get install --yes gcc-arm-linux-gnueabihf

# install ARM cross compiler toolchains for 64-bit ARM64
# (only install on amd64 platforms)
RUN if [ "$TARGETARCH" = "amd64" ] ; then apt-get --yes install gcc-aarch64-linux-gnu ; fi

# install RaspberryPi ARM cross compiler toolchains for 32-bit ARMHF (ARMv6+ARMv7+ARMv8)
# (get the latest RPI cross compiler tools from the GitHub repo)
RUN git clone --progress --verbose https://github.com/raspberrypi/tools.git --depth=1 /opt/rpi-tools

# clean APT cache
RUN apt-get clean

# configure the PATH for ARM cross compiler toolchains for 32-bit ARMHF (ARMv6 + ARMv7)
ENV PATH="/opt/rpi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:${PATH}"

# configure build time environment variables
ENV PI4J_BUILDER_NATIVE="$BUILDVERSION"
ENV PI4J_BUILDER_DATE="$BUILDDATE"
ENV PI4J_CROSS_COMPILE="true"
ENV RPI_CROSS_COMPILE="true"

# always launch build script on container startup
ENTRYPOINT ["./build.sh"]
