#!/usr/bin/env python
#
# Copyright 2016 the original author or authors.
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

FROM ubuntu:xenial

MAINTAINER Zsolt Haraszti <zharaszt@ciena.com>
MAINTAINER Ali Al-Shabibi <ali.al-shabibi@onlab.us>
MAINTAINER Nathan Knuth   <nathan.knuth@tibitcom.com>

# Update to have latest images
RUN apt-get update && \
    apt-get install -y python python-pip openssl

COPY requirements.txt /tmp/requirements.txt

# pip install cython enum34 six && \
# Install app dependencies
RUN apt-get install -y wget build-essential make gcc binutils python-dev libffi-dev libssl-dev git && \
    pip install -r /tmp/requirements.txt && \
    apt-get purge -y wget build-essential make gcc binutils python-dev libffi-dev libssl-dev git && \
    apt-get autoremove -y

# Bundle app source
COPY voltha /voltha

# Exposing process and default entry point
# EXPOSE 8000
CMD ["python", "voltha/main.py"]
