#!/bin/bash
# Copyright 2018 by Blockchain Technology Partners Limited
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#set -x # DEBUG

##
# Make a release of Hyperledger Brooklyn Sawtooth
#
# Usage: release.sh old-version new-version
##

# set versions
OLD_VERSION=$1
NEW_VERSION=$2

if [ -z "${OLD_VERSION}" -o -z "${NEW_VERSION}" -o "${OLD_VERSION}" == "${NEW_VERSION}" ] ; then
    echo "Usage: $(basename $0) old-version new-version"
    exit 1
fi

# find all files with version variable
find . \
    \( -name target -o -name .git -o -name build \) -prune \
    -o -type f -print |
    xargs grep "HYPERLEDGER_BROOKLYN_SAWTOOTH_VERSION" |
    cut -d: -f1 |
    uniq |
    xargs sed -i.bak -e "/HYPERLEDGER_BROOKLYN_SAWTOOTH_VERSION/s/${OLD_VERSION}/${NEW_VERSION}/g" $FILES
find . -name "*.bak" -delete
find . \
    \( -name target -o -name .git -o -name build \) -prune \
    -o -type f -print |
    xargs grep "${OLD_VERSION}"
