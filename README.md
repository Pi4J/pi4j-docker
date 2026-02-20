# Pi4J Docker Builder Images

---

### Overview:

This project contains the Dockerfiles and build scripts to create the Pi4J builder  
docker images used for compiling/building the Pi4J projects.  The Pi4J builder images 
include the following:

 - **[Pi4J Base Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder-base)** `pi4j/pi4j-builder-base:latest` : 
 This is the base image used by all the other builder images.  It's based on Ubuntu 22.04 
 with JDK 21 and Maven pre-installed.  This image's entry point is a Bash shell.
 (https://hub.docker.com/repository/docker/pi4j/pi4j-builder-base)
 
 - **[Pi4J Native Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder-native)** `pi4j/pi4j-builder-native:latest` : 
 This image is derived from `pi4j/pi4j-builder-base` and adds support for native cross-compilers 
 and build tools for architectures: `arm`, `armhf`, `aarch64/arm64`.  This image's 
 entry point is a bash shell attempting to execute the file `./build.sh` in the volume mounted 
 under the `/build` path.
 
 - **[Pi4J v2.0 Builder](https://hub.docker.com/repository/docker/pi4j/pi4j-builder:2.0)** `pi4j/pi4j-builder:2.0` : 
 This image is derived from `pi4j/pi4j-builder-native` and additionally includes pre-cached Maven 
 build plugins and dependencies for [Pi4J v2.0](http://github.com/Pi4J/pi4j-v2) builds.  This image's 
 entry point is a Maven shell.  If not explicitly provided, the default maven build arguments will be: 
 `clean install -DskipTests -Pnative,cross-compile`.  This will effectively build all Pi4J projects including
 the native library projects which will be cross-compiled for RaspberryPi/ARM (32-bit & 64-bit) devices.  

**Note:** Pi4J versions prior to v2 are not supported in these Docker images.

### How to Build the Pi4J Project using these Docker Images:

#### Build Pi4J v2+

Navigate to the parent "pi4j" directory and execute the following Docker commands:  
```
docker pull pi4j/pi4j-builder:2.0
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

 
---
### How to Build the Pi4J Docker Builder Images:

The Pi4J Docker Builder images are built using the following shell scripts:
| Docker Command Argument  | Description |
| ------------- | ------------- |
| `./build.sh`  | builds all the Pi4J Builder images locally for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./deploy.sh`  | builds all the Pi4J Builder images and pushes to DockerHub for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./clean.sh`  | cleans the build environment and removes images from the local system for all the Pi4J Builder images. |
| `./pi4j-builder-base/build.sh`  | builds the Pi4J Base Builder image locally for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-base/build.sh --push`  | builds the Pi4J Base Builder images and pushes to DockerHub for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-base/clean.sh`  | cleans the build environment and removes images from the local system for the Pi4J Base Builder image. |
| `./pi4j-builder-native/build.sh`  | builds the Pi4J Native Builder image locally for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-native/build.sh --push`  | builds the Pi4J Native Builder image and pushes to DockerHub for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-native/clean.sh`  | cleans the build environment and removes images from the local system for the Pi4J Native Builder image. |
| `./pi4j-builder-2.0/build.sh`  | builds the Pi4J Builder image for Pi4J v2+  locally for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-2.0/build.sh --push`  | builds the Pi4J Builder image for Pi4J v2+ and pushes to DockerHub for: `x86_64/amd64` & `aarch64/arm64` architectures. |
| `./pi4j-builder-2.0/clean.sh`  | cleans the build environment and removes images from the local system for the Pi4J Builder image for Pi4J v2+. |
