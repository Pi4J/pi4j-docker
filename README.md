# Pi4J Docker Builder Images

---

### Overview:

This project contains the Dockerfiles and build scripts to create the Pi4J builder  
docker images used for compiling/building the Pi4J projects.  The Pi4J builder images 
include the following:

 - **[Pi4J Base Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder-base)** `pi4j/pi4j-builder-base:latest` : 
 This is the base image used by all the other builder images.  It's based on Ubuntu 18.04 
 with JDK 11 and Maven pre-installed.
 (https://hub.docker.com/repository/docker/pi4j/pi4j-builder-base)
 
 - **[Pi4J Native Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder-native)** `pi4j/pi4j-builder-native:latest` : 
 This image is derived from `pi4j/pi4j-builder-base` and adds support for native cross-compilers 
 and build tools for architectures: `arm`, `armhf`, `aarch64/arm64`.  
  
 - **[Pi4J v1.4 Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder:1.4)** `pi4j/pi4j-builder:1.4` : 
 This image is derived from `pi4j/pi4j-builder-native` and additionally includes pre-cached Maven 
 build plugins and dependencies for [Pi4J v1.4](http://github.com/Pi4J/pi4j) builds.  

 - **[Pi4J v2.0 Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder:2.0)** `pi4j/pi4j-builder:2.0` : 
 This image is derived from `pi4j/pi4j-builder-native` and additionally includes pre-cached Maven 
 build plugins and dependencies for [Pi4J v2.0](http://github.com/Pi4J/pi4j-v2) builds.  

---
### Prerequisites:
``` 
#-----------------------------------------------------------------------------------------
# !! THIS DOCKER BUILD REQUIRES THE EXPERIMENTAL DOCKER BUILDX PLUGIN !!
#-----------------------------------------------------------------------------------------
#
# REF: https://docs.docker.com/buildx/working-with-buildx/
#
# Docker Buildx is a CLI plugin that extends the docker command with the
# full support of the features provided by Moby BuildKit builder toolkit.
# It provides the same user experience as docker build with many new
# features like creating scoped builder instances and building against
# multiple nodes concurrently.
#
# This is an experimental feature.
#
# Experimental features provide early access to future product functionality.
# These features are intended for testing and feedback only as they may change
# between releases without warning or can be removed entirely from a future
# release. Experimental features must not be used in production environments.
# Docker does not offer support for experimental features.
#
#-----------------------------------------------------------------------------------------
```
---
### How to Build the Pi4J project using Docker:

####Build Pi4J v1.4

Navigate to the parent "pi4j" directory and execute the following Docker command:  
```
docker run \\
    --user "$(id -u):$(id -g)" \
    --rm \
    --volume $(pwd):/build \
    pi4j/pi4j-builder:1.4
```
| Docker Command Argument  | Description |
| ------------- | ------------- |
| `run`  | launch the Pi4J Builder container  |
| `--user` | Run the build container with your user id/group id. (_this is not needed for Window or MacOS_)  |
| `--rm`  | Remove the temporary build container upon completion  |
| `--volume`  | Mount the current directory to the Docker container's `/build` path.  This is where the container will attempt to locate and execute the `./build.sh` script. |
| `pi4j/pi4j-builder:1.4` | The Pi4J build container image name and version. |

####Build Pi4J v2.0

Navigate to the parent "pi4j" directory and execute the following Docker command:  
```
docker run \\
    --user "$(id -u):$(id -g)" \
    --rm \
    --volume $(pwd):/build \
    pi4j/pi4j-builder:2.0
```
| Docker Command Argument  | Description |
| ------------- | ------------- |
| `run`  | launch the Pi4J Builder container  |
| `--user` | Run the build container with your user id/group id. (_this is not needed for Window or MacOS_)  |
| `--rm`  | Remove the temporary build container upon completion  |
| `--volume`  | Mount the current directory to the Docker container's `/build` path.  This is where the container will attempt to locate and execute the `./build.sh` script. |
| `pi4j/pi4j-builder:2.0` | The Pi4J build container image name and version. |

 
