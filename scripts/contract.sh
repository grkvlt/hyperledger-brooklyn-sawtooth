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
# Deploy a smart contract using Truffle.
#
# Usage: contract.sh github-repo-url account-id
##

# set variables
GITHUB_REPO_URL=$1
ACCOUNT_ID=$2
ID=$$

# clone github repository
[ -d /contracts ] || mkdir /contracts
git clone "${GITHUB_REPO_URL}" /contracts/${ID} > /dev/null 2>&1
cd /contracts/${ID}

# install required node modules
npm install dotenv@5.0.0 > /dev/null 2>&1
npm install > /dev/null 2>&1

# set required environment
>> .env <<EOF
SETH_DEPLOY_ACCOUNT_ID=${ACCOUNT_ID}
SETH_RPC_HOST=${SETH_RPC_HOST}
EOF

# set sawtooth network configuration
> sawtooth.js <<EOF
    'sawtooth-${ID}': {
      from: '0x' + process.env.SETH_DEPLOY_ACCOUNT_ID,
      network_id: '19',
      host: process.env.SETH_RPC_HOST,
      port: 3030
    },
EOF

# update truffle configuration
if [ ! -f truffle.js ] ; then
  > truffle.bak <<EOF
module.exports = {
  networks: {
  }
}
EOF
else
  mv truffle.js truffle.bak
fi
(
  if ! grep -q "dotenv" truffle.bak ; then
    echo "require('dotenv').config();"
  fi
  sed "/networks.*:.*{/r sawtooth.js" truffle.bak
) > truffle.js
rm truffle.bak

# deploy
truffle compile > /dev/null 2>&1
truffle deploy --network sawtooth-${ID}
