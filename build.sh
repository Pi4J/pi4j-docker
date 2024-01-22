#!/bin/bash -e
###
# #%L
# **********************************************************************
# ORGANIZATION  :  Pi4J
# PROJECT       :  Pi4J :: Deploy All Docker Images for Pi4J Builders
# FILENAME      :  build.sh
#
# This file is part of the Pi4J project. More information about
# this project can be found here:  https://pi4j.com/
# **********************************************************************
# %%
# Copyright (C) 2012 - 2020 Pi4J
# %%
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# #L%
###

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

BASE_DIR=$PWD

echo
echo "**********************************************************************"
echo "*                                                                    *"
echo "*  BUILDING ALL Pi4J BUILDERS (DOCKER IMAGES)                        *"
echo "*                                                                    *"
echo "**********************************************************************"
echo

#docker buildx rm --force pi4j-builder || true
#docker buildx create --use --bootstrap \
#  --driver=docker-container \
#  --name pi4j-builder

# **********************************************************************
# BUILDING Pi4J BASE BUILDER (DOCKER IMAGE)
# **********************************************************************
cd $BASE_DIR/pi4j-builder-base
./build.sh $@

# **********************************************************************
# BUILDING Pi4J NATIVE BUILDER (DOCKER IMAGE)
# **********************************************************************
cd $BASE_DIR/pi4j-builder-native
./build.sh $@

# **********************************************************************
# BUILDING Pi4J v2.0 BUILDER (DOCKER IMAGE)
# **********************************************************************
#cd $BASE_DIR/pi4j-builder-2.0
#./build.sh $@

# **********************************************************************
# BUILDING Pi4J REPO BUILDER (DOCKER IMAGE)
# **********************************************************************
#cd $BASE_DIR/pi4j-builder-repo
#./build.sh $@

#docker buildx rm --force pi4j-builder

echo
echo "**********************************************************************"
echo "*                                                                    *"
echo "* FINISHED BUILDING ALL Pi4J BUILDERS (DOCKER IMAGES)                *"
echo "*                                                                    *"
echo "**********************************************************************"
echo