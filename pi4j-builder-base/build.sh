#!/bin/bash -e
###
# #%L
# **********************************************************************
# ORGANIZATION  :  Pi4J
# PROJECT       :  Pi4J :: Build Docker Image for Pi4J Base Builder
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

# docker image version
VERSION=2.0

echo
echo "**********************************************************************"
echo "* BUILDING Pi4J BASE BUILDER (DOCKER IMAGE)                          *"
echo "**********************************************************************"
echo

docker build \
  --build-arg BUILDDATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg BUILDVERSION="$VERSION" \
  --tag pi4j/pi4j-builder-base:$VERSION \
  --tag pi4j/pi4j-builder-base:latest \
  . $@
#  --builder=pi4j-builder --load . $@
#  --platform linux/amd64,linux/arm64 \
