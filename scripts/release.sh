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
# Environment:
#     VERSION - String indicating version to be changed
#     BRANCH - Set to true to make a release branch
##

# set versions
OLD_VERSION=$1
NEW_VERSION=$2
VERSION="HYPERLEDGER_BROOKLYN_SAWTOOTH_VERSION"
BRANCH="${BRANCH:-false}"

if [ -z "${OLD_VERSION}" -o -z "${NEW_VERSION}" -o "${OLD_VERSION}" == "${NEW_VERSION}" ] ; then
    echo "Usage: $(basename $0) old-version new-version"
    exit 1
fi
${BRANCH} && if grep "release/${NEW_VERSION}" <(git branch -l) > /dev/null 2>&1 ; then
    echo "Error: Version ${NEW_VERSION} already exists"
    exit 1
fi

# create release branch
${BRANCH} && git checkout -b release/${NEW_VERSION}

# find all files with version variable
find . \
    \( -name target -o -name .git -o -name build \) -prune \
    -o -type f -print |
    xargs grep "${VERSION}" |
    cut -d: -f1 |
    uniq |
    xargs sed -i.bak -e "/${VERSION}/s/${OLD_VERSION}/${NEW_VERSION}/g" $FILES
find . -name "*.bak" -delete

# edit any files that still have old version
continue="y"
while [ "${continue}" == "y" ] ; do
    extra=$(find . \
        \( -name target -o -name .git -o -name build \) -prune \
        -o -type f -print |
        xargs grep "${OLD_VERSION}" |
        cut -d: -f1 |
        uniq)
    continue="n"
    if [ $(echo ${extra} | wc -w) -gt 0 ] ; then
        grep "${OLD_VERSION}" ${extra}
        if ${BRANCH} ; then
            read -p "Edit? (y/n) " -i y -e edit
            if grep -i "y" <<<"${edit}" > /dev/null 2>&1 ; then
                ${VISUAL:-vi} ${extra}
                continue="y"
            fi
        fi
    fi
done

# commit changes to release branch
if ${BRANCH} ; then
    git commit --all -s -m "Version ${NEW_VERSION}"
    git tag -a -m "Version ${NEW_VERSION}" v${NEW_VERSION}
    git push --follow-tags origin release/${NEW_VERSION}
fi
