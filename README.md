# Solidity-Eternal-Proxy


## Storage Contracts:

1. ArithmeticStorage (Storage contract - storage for Arithmetic)

## Logic Contracts:

1. Arithmetic 
   - Logic contract containing add and subtract operations
   - inherits ArithmeticStorage

## ProxyLogic Contract:

1. ArithmeticStorageProxy
   - Proxy contract for Arithmetic
   - inherits ArithmeticStorage

```
User ---- tx --- ArithmeticStorageProxy
                        |
                        | ----------> ArithmeticStorage
```


```
    =========================          -------     =======================
    ║  ArithmeticStorage     ║         | Proxy |   ║ UpgradeabilityStorage ║
     =========================          -------     =======================
              ↑            ↑                            ↑                ↑            
              |            |                            |            ---------------------
          ----------       |                            |           | UpgradeabilityProxy |
         | Arithmetic |    |                            |            ---------------------
          ----------       |                            |               ↑
              ↑            |                       
              |            |                      
          --------------   |                       
         | Arithmetic_v1|  |                             ↑
          --------------   |______ -------------------------
                                  | ArithmeticStorageProxy |
                                   -------------------------
```

## Proxy Contract:

1. Proxy (Proxy with default callback and assembly code)
2. UpgradeabilityStorage (Contains version and implementation address of underlying logic-contract)
3. UpgradeabilityProxy (inherits Proxy and UpgradeabilityStorage)


## Reference:

- https://blog.openzeppelin.com/proxy-patterns/

- Eternal Storage Pattern: 
  https://blog.openzeppelin.com/smart-contract-upgradeability-using-eternal-storage/

- Open-zeppelin SDK for Proxy contracts (Updated):
  https://docs.openzeppelin.com/sdk/2.6/pattern.html

- https://ethereum.stackexchange.com/questions/50671/upradeable-proxy-library-throws-on-any-function-how-to-connect-proxy-and-mainco  


### usage:

```
run ganache-cli in console
```

```js
ganache-cli -p 8545
```

```
Open a new console
open truffle console, by command: truffle console
command should open a console for truffle to interact with ganache-cli (instance)
Now in the truffle-console, migrate contracts 
```

```js
truffle(development)> migrate --reset
```

```
command console log will look like:
```

```js
MBP15-30K3JGH8:Solidity-Eternal-Proxy-master lakshmi.pabbisetti$ truffle console
truffle(development)> migrate --reset

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.



Starting migrations...
======================
> Network name:    'development'
> Network id:      1575629692248
> Block gas limit: 0x6691b7


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0xe17d9bc916085ebcbf18f7e75684531db27cb0f62cf20c603af46270a7304bca
   > Blocks: 0            Seconds: 0
   > contract address:    0xC50f9457796e2C98C41C3C742674Ae3e016068F7
   > block number:        1
   > block timestamp:     1575629852
   > account:             0xe1d881ed85566E770524a38cb5d77f2C73D77580
   > balance:             99.994334
   > gas used:            283300
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.005666 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:            0.005666 ETH


2_ArithmeticProxy_migration.js
==============================

   Deploying 'ArithmeticStorageProxy'
   ----------------------------------
   > transaction hash:    0x838e20554df35f96d2bbd6c80f296a4791771ed02804fbad0528590104e04646
   > Blocks: 0            Seconds: 0
   > contract address:    0x8B10ca05da5b704F084025D0364D813D9Ef0160b
   > block number:        3
   > block timestamp:     1575629852
   > account:             0xe1d881ed85566E770524a38cb5d77f2C73D77580
   > balance:             99.98343368
   > gas used:            502988
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01005976 ETH

arithmeticStorageProxy contract is deployed : 0x8B10ca05da5b704F084025D0364D813D9Ef0160b
deployed arithmeticStorageProxy with address: 0x8B10ca05da5b704F084025D0364D813D9Ef0160b

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01005976 ETH


3_Arithmetic_migration.js
=========================

   Deploying 'Arithmetic'
   ----------------------
   > transaction hash:    0x15e58fdf87e7299b5d49cdbab6139d49182fe50a58209e63ab679c542d92b012
   > Blocks: 0            Seconds: 0
   > contract address:    0x8345396d16b52505f71310F5C097a6FA367a56cE
   > block number:        5
   > block timestamp:     1575629853
   > account:             0xe1d881ed85566E770524a38cb5d77f2C73D77580
   > balance:             99.96544502
   > gas used:            872405
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0174481 ETH

arithmetic contract is deployed : 0x8345396d16b52505f71310F5C097a6FA367a56cE
deployed arithmetic with address: 0x8345396d16b52505f71310F5C097a6FA367a56cE
deployed arithmetic with constructor data: 0xf62d18880000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0174481 ETH


Summary
=======
> Total deployments:   3
> Final cost:          0.03317386 ETH


truffle(development)> 
```

```
After deployment, set the implementation of Arithmetic to ArithmeticStorageProxy via upgrade method call
```

```js
truffle(development)> var arithmeticStorageProxy = await ArithmeticStorageProxy.deployed()
truffle(development)> arithmeticStorageProxy.upgradeTo('1','0x8345396d16b52505f71310F5C097a6FA367a56cE')
```

```
1st Upgrade call is to set the implementation Address for the very first time
Log looks like:
```

```js
truffle(development)> var arithmeticStorageProxy = await ArithmeticStorageProxy.deployed()
undefined
truffle(development)> arithmeticStorageProxy.upgradeTo('1','0x8345396d16b52505f71310F5C097a6FA367a56cE')
{
  tx: '0xaab0613798ec9f838560aaff1bc75c4b7c760768c020aba2777d7c29b1176c30',
  receipt: {
    transactionHash: '0xaab0613798ec9f838560aaff1bc75c4b7c760768c020aba2777d7c29b1176c30',
    transactionIndex: 0,
    blockHash: '0x6063c9ed1a73f76bf8dd815a97a227c89d267fb29c0ae9db4e5100e11c1e6246',
    blockNumber: 7,
    from: '0xe1d881ed85566e770524a38cb5d77f2c73d77580',
    to: '0x8b10ca05da5b704f084025d0364d813d9ef0160b',
    gasUsed: 67253,
    cumulativeGasUsed: 67253,
    contractAddress: null,
    logs: [ [Object] ],
    status: true,
    logsBloom: '0x00000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000100000000000010000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000100000000000000000000000000000',
    v: '0x1c',
    r: '0x2c07e3a38ae5f4db3539771202139364fd2e1cdb1be1cfb5321622eb6a664c00',
    s: '0x7ed5c7250e8842fcb58cb63c8fa07f5f2bd89659e512e9fb1ec155ae1f8090a7',
    rawLogs: [ [Object] ]
  },
  logs: [
    {
      logIndex: 0,
      transactionIndex: 0,
      transactionHash: '0xaab0613798ec9f838560aaff1bc75c4b7c760768c020aba2777d7c29b1176c30',
      blockHash: '0x6063c9ed1a73f76bf8dd815a97a227c89d267fb29c0ae9db4e5100e11c1e6246',
      blockNumber: 7,
      address: '0x8B10ca05da5b704F084025D0364D813D9Ef0160b',
      type: 'mined',
      id: 'log_d053cd71',
      event: 'Upgraded',
      args: [Result]
    }
  ]
}
truffle(development)> 
```

```
Now Proxy is ready for test verification

functions in Arithmetic contract are:
1. add
2. sub
3. multiply
4. div
5. doubleAdder
6. getResult
7. getResultFromMap

1-5 actions are to perform some arithmetic operation on numbers
6,7 - are about retrieving results stored in the storageContract
```

```
Storage:

Storage is externalized as part of proxy design pattern
ArithmeticStorage.sol is the solidity contract which stores the state:
```

```js

pragma solidity ^0.5.1;

contract ArithmeticStorage {
    uint256[] resultArray;
    mapping(string => uint256) resultmap;
}
```

```
Storage details:
1. resultArray
   All arithmetic operation results are pushed in to this array

2. resultmap
   result of last computation of each operation (add/multiply/div) are stored in this mapping with action name as key
```


### Test Via Proxy:

```js

truffle(development)> proxInst.add(100,21)
{
  tx: '0x23fb44314ecb4b8319410c9487d9d31a6666c50b3a2020aad4636a0a193b24a1',
  receipt: {
    transactionHash: '0x23fb44314ecb4b8319410c9487d9d31a6666c50b3a2020aad4636a0a193b24a1',
    transactionIndex: 0,
    blockHash: '0xbaa0227f6a4b12a300a0d800b707d40cea2c1e61350bcdad74cabed046696409',
    blockNumber: 8,
    from: '0xe1d881ed85566e770524a38cb5d77f2c73d77580',
    to: '0x8b10ca05da5b704f084025d0364d813d9ef0160b',
    gasUsed: 85702,
    cumulativeGasUsed: 85702,
    contractAddress: null,
    logs: [ [Object] ],
    status: true,
    logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000a00000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000001000800000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000',
    v: '0x1c',
    r: '0x853ef809c34e4aaf895f47ea3587ec3dacbab1e09ac15ee2729d8ca52db323c5',
    s: '0x4e9c51b48ca12067071d19d20d2127d2e4ccabb2e2fcdefe1de761d5f75c446d',
    rawLogs: [ [Object] ]
  },
  logs: [
    {
      logIndex: 0,
      transactionIndex: 0,
      transactionHash: '0x23fb44314ecb4b8319410c9487d9d31a6666c50b3a2020aad4636a0a193b24a1',
      blockHash: '0xbaa0227f6a4b12a300a0d800b707d40cea2c1e61350bcdad74cabed046696409',
      blockNumber: 8,
      address: '0x8B10ca05da5b704F084025D0364D813D9Ef0160b',
      type: 'mined',
      id: 'log_821941fe',
      event: 'addEvent',
      args: [Result]
    }
  ]
}
truffle(development)> var addResult = await proxInst.add(100,98)
undefined
truffle(development)> addResult
{
  tx: '0x24afb01413883d36ee71fbdfec733a52f4da967c8c8b3d81d97789765da24e5d',
  receipt: {
    transactionHash: '0x24afb01413883d36ee71fbdfec733a52f4da967c8c8b3d81d97789765da24e5d',
    transactionIndex: 0,
    blockHash: '0x8e8466e79d88bf2134990171f3370f2a365014e00b27a15d840dd01653aa20b0',
    blockNumber: 9,
    from: '0xe1d881ed85566e770524a38cb5d77f2c73d77580',
    to: '0x8b10ca05da5b704f084025d0364d813d9ef0160b',
    gasUsed: 55702,
    cumulativeGasUsed: 55702,
    contractAddress: null,
    logs: [ [Object] ],
    status: true,
    logsBloom: '0x00000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020200000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000800000000000000000000000000010000000000000000000000000000004000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000',
    v: '0x1b',
    r: '0xa7e5822f4b4514d7d7ed4e4ae6c9786d0b8614c84e94c5b807dffa60bd5a3e05',
    s: '0x551b18860ecf03b871a1e173e755bd085d5c4ed6ec90e4e145cc701062620439',
    rawLogs: [ [Object] ]
  },
  logs: [
    {
      logIndex: 0,
      transactionIndex: 0,
      transactionHash: '0x24afb01413883d36ee71fbdfec733a52f4da967c8c8b3d81d97789765da24e5d',
      blockHash: '0x8e8466e79d88bf2134990171f3370f2a365014e00b27a15d840dd01653aa20b0',
      blockNumber: 9,
      address: '0x8B10ca05da5b704F084025D0364D813D9Ef0160b',
      type: 'mined',
      id: 'log_27648927',
      event: 'addEvent',
      args: [Result]
    }
  ]
}
truffle(development)> proxInst.getResult()
[
  BN {
    negative: 0,
    words: [ 121, <1 empty item> ],
    length: 1,
    red: null
  },
  BN {
    negative: 0,
    words: [ 198, <1 empty item> ],
    length: 1,
    red: null
  }
]
truffle(development)> 
```

### upgrade:

```js
truffle(development)> var proxyInstanceUpgraded = await ArithmeticProxy.deployed()
proxyInstanceUpgraded.upgradeTo('1','0x94998fC798F3B9F97e59D0b789AfA2423079
BCc5')
var proxInstUpg = await ArithmeticAdvanced.at(ArithmeticProxy.address)
```


### Misc Reference:

Aside that, it is as usual as typical truffle/react/web3/solidity project.

- https://blog.gnosis.pm/solidity-delegateproxy-contracts-e09957d0f201