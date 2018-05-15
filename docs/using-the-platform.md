Using the Platform
==================

If you have not done so already, use the [getting started](./getting-started.md) instructions to create a Sawtooth platform deployment.

## Deploying a Smart Contract using Truffle

We will use the [Tierion](https://github.com/Tierion/tierion-erc20-smart-contract) repository, which contains Solidity code for an ERC-20 token smart contract as an example.

The Apache Brooklyn deployed Hyperledger Sawtooth provides this functionality via an effector on the `sawtooth-platform-server-node` entity.

To call the effector you will need to provide the ID of the admin account. You can get this from the `sawtooth.seth.account` sensor on `sawtooth-platform-server-node`. Executing the `status.sh` script on the `brooklyn` container will also provide this information.

    $ docker exec brooklyn setatus.sh example-sawtooth-platform
    {
      "seth.account": ""
    }

Once you have noted this value, open the effectors tab and click invoke on `deploy-smart-contract`.

For `source` enter `https://github.com/Tierion/tierion-erc20-smart-contract` and for the `account` enter the ID from the `sawtooth.seth.account`.

Click invoke, and the truffle deploy process will be started. You can follow the progress of this on the activities tab of the `sawtooth-platform-server-node`, which should look like the following output:

    Using network 'sawtooth-12309'.

    Running migration: 1_initial_migration.js
      Deploying Migrations...
      ... 0xb3dbfee0c6fc4084f1418c93727e43486ef93aa5668fcdd0cbb5abb7ee5b2c921b137df46968ab7a8a7cfa7a793888799d0558c862fd5d34516ddc1c040cf279
      Migrations: 0x31067551e14280092996e96208dc8f5dc0f1e98b
    Saving successful migration to network...
      ... 0x41f923c0f3edbca502eb53c3048385e069b18c19c96bc97af6ebe0db67ca97e14e379c9ff0bde562b8df8dfba84baa7866788d6def96ae5a124c009ad854feaa
    Saving artifacts...
    Running migration: 2_deploy_contracts.js
      Deploying TierionNetworkToken...
      ... 0xcb5c962637b0e78fb8194a0c99235ea23874de0006862050efdb43fbc7c40c0239c37806e5b1f0e8c079a0b700dd6342ea68ce67d0cb0d78f6fce43ae3dabf97
      TierionNetworkToken: 0xd262156d0838bdbb6cd78fda6a5f0b3964297762
    Saving successful migration to network...
      ... 0xa996cc92010ecd0ce03c54ce04255024d3c1628a335fec869436cd51c93fb912365b8b62090adbf6cfa22c301c249f6bed29d182f64af9e6617ad7329368fe87
    Saving artifacts...


---
Copyright 2018 Blockchain Technology Partners Limited; Licensed under the [Apache License, Version 2.0](../LICENSE)
