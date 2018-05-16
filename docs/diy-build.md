Building the Platform
=====================

You can also build a private version of the Sawtooth platform, with your own copies of the Docker images and blueprints. To do this you must also have Maven installed, as well as git, and have access to a Docker Hub account.

## Open Source Components

The [`images.sh`](../scripts/images.sh) builds the required Docker images for the platform from theit GitHub source. Currently it uses the following repositories, which are forked from the original Hyperledger repositories, and the specified branches, whoch have extra patches and features added. These commits will eventually be merged back into the mainline Hyperledger code.

**Hyperledger Sawtooth Core**
- `https://github.com/blockchaintp/sawtooth-core.git` `1-0-staging-01`

**Hyperledger Sawtooth SDK Go**
- `https://github.com/blockchaintp/sawtooth-sdk-go.git` `master`

**Hyperledger Sawtooth Seth**
- `https://github.com/blockchaintp/sawtooth-seth.git` `seth-rpc-eth-call`

**Hyperledger Next Directory**
- `https://github.com/blockchaintp/sawtooth-next-directory.git` `master`

**Hyperledger Sawtooth Explorer**
- `https://github.com/blockchaintp/sawtooth-explorer.git` `standalone-dockerfile`

## Docker Images

The following Docker images are maintained as part of the platform. If you want to create your own provate version, then then you will need to recreate these images on your own Docker repository.

**Hyperledger Brooklyn Sawtooth**
- [`brooklyn-sawtooth`](https://hub.docker.com/r/blockchaintp/brooklyn-sawtooth)
- [`sawtooth-contracts`](https://hub.docker.com/r/blockchaintp/sawtooth-contracts)

**Hyperledger Sawtooth Core**
- [`sawtooth-build-debs`](https://hub.docker.com/r/blockchaintp/sawtooth-build-debs)
- [`sawtooth-validator`](https://hub.docker.com/r/blockchaintp/sawtooth-validator)
- [`sawtooth-xo-tp-python`](https://hub.docker.com/r/blockchaintp/sawtooth-xo-tp-python)
- [`sawtooth-poet-validator-registry-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-poet-validator-registry-tp)
- [`sawtooth-intkey-tp-python`](https://hub.docker.com/r/blockchaintp/sawtooth-intkey-tp-python)
- [`sawtooth-identity-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-identity-tp)
- [`sawtooth-block-info-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-block-info-tp)
- [`sawtooth-settings-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-settings-tp)
- [`sawtooth-rest-api`](https://hub.docker.com/r/blockchaintp/sawtooth-rest-api)
- [`sawtooth-smallbank-tp-go`](https://hub.docker.com/r/blockchaintp/sawtooth-smallbank-tp-go)
- [`sawtooth-xo-tp-go`](https://hub.docker.com/r/blockchaintp/sawtooth-xo-tp-go)
- [`sawtooth-intkey-tp-go`](https://hub.docker.com/r/blockchaintp/sawtooth-intkey-tp-go)
- [`sawtooth-dev-rust`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-rust)
- [`sawtooth-battleship-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-battleship-tp)
- [`sawtooth-dev-python`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-python)
- [`sawtooth-dev-poet-sgx`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-poet-sgx)
- [`sawtooth-dev-javascript`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-javascript)
- [`sawtooth-intkey-tp-javascript`](https://hub.docker.com/r/blockchaintp/sawtooth-intkey-tp-javascript)
- [`sawtooth-xo-tp-javascript`](https://hub.docker.com/r/blockchaintp/sawtooth-xo-tp-javascript)
- [`sawtooth-dev-java`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-java)
- [`sawtooth-intkey-tp-java`](https://hub.docker.com/r/blockchaintp/sawtooth-intkey-tp-java)
- [`sawtooth-xo-tp-java`](https://hub.docker.com/r/blockchaintp/sawtooth-xo-tp-java)
- [`sawtooth-dev-go`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-go)
- [`sawtooth-dev-cxx`](https://hub.docker.com/r/blockchaintp/sawtooth-dev-cxx)
- [`sawtooth-stats-influxdb`](https://hub.docker.com/r/blockchaintp/sawtooth-stats-influxdb)
- [`sawtooth-stats-grafana`](https://hub.docker.com/r/blockchaintp/sawtooth-stats-grafana)
- [`apache-basic_auth_proxy`](https://hub.docker.com/r/blockchaintp/apache-basic_auth_proxy)

**Hyperledger Sawtooth Seth**
- [`sawtooth-seth-tp`](https://hub.docker.com/r/blockchaintp/sawtooth-seth-tp)
- [`sawtooth-seth-rpc`](https://hub.docker.com/r/blockchaintp/sawtooth-seth-rpc)
- [`sawtooth-seth-cli`](https://hub.docker.com/r/blockchaintp/sawtooth-seth-cli)

**Hyperledger Next Directory**
- [`rbac-server-production`](https://hub.docker.com/r/blockchaintp/rbac-server-production)
- [`rbac-ledger-sync-production`](https://hub.docker.com/r/blockchaintp/rbac-ledger-sync-production)
- [`rbac-tp-production`](https://hub.docker.com/r/blockchaintp/rbac-tp-production)
- [`rbac-ui-production`](https://hub.docker.com/r/blockchaintp/rbac-ui-production)

**Hyperledger Sawtooth Explorer**
- [`sawtooth-explorer`](https://hub.docker.com/r/blockchaintp/sawtooth-explorer)

## Creating a Private Build

Set the `REPO` environment variable to the name of a Docker Hub organisation or account you control and wish the images to be accessible from. The scripts can then be executed in the order shown below to recreate and deploy a copy of the Docker images. The [`images.sh`](../scripts/images.sh) and [`build.sh`](../scripts/build.sh) scripts both have other environment variables that can be set to change the source GitHub repository locations and the target image versions if required.

    $ export REPO=<your Docker hub account name here>
    $ ./scripts/clean.sh
    ...
    $ ./scripts/images.sh
    ...
    $ ./scripts/deploy.sh
    ...
    $ ./scripts/build.sh clean deploy
    ...

Update your blueprints so the value of `sawtooth.repository` refers to your private repository on Docker Hub, and then deploy.


---
Copyright 2018 Blockchain Technology Partners Limited; Licensed under the [Apache License, Version 2.0](../LICENSE)
