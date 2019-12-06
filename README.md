# Solidity-Eternal-Proxy


## Storage Contracts:

1. ArithmeticStorage (Storage contract - storage for Arithmetic)
2. ArithmeticAdvancedStorage (Storage contract - storage for ArithmeticAdvanced)

## Logic Contracts:

1. Arithmetic 
   - Logic contract containing add and subtract operations
   - inherits ArithmeticStorage

2. ArithmeticAdvanced 
   - Logic contract containing advanced operations - multiplication
   - inherits ArithmeticAdvancedStorage

## ProxyLogic Contract:

1. ArithmeticProxy
   - Proxy contract for Arithmetic
   - inherits 

```
User ---- tx --- ArithmeticProxy
                        |
                        | ----------> Arithmetic
                        |
                        |-----------> Arithmetic_v1
                        |
                        |-----------> Arithmetic_v2
```

```
    =========================     ============================     -------     =======================
    ║  ArithmeticStorage     ║   ║ UpgradeabilityOwnerStorage ║   | Proxy |   ║ UpgradeabilityStorage ║
     =========================     ============================     -------     =======================
              ↑            ↑                            ↑                ↑            ↑
              |            |                            |            ---------------------
          ----------       |                            |           | UpgradeabilityProxy |
         | Arithmetic |    |                            |            ---------------------
          ----------       |                            |               ↑
              ↑            |                       --------------------------
              |            |                      | OwnedUpgradeabilityProxy |
          --------------   |                       --------------------------
         | Arithmetic_v1|  |                             ↑
          --------------   |______ -------------------------
                                  | ArithmeticStorageProxy |
                                   -------------------------
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
truffle(development)> migrate --reset
truffle(development)> var proxInst = await Arithmetic.at(ArithmeticProxy.address)
truffle(development)> proxInst.add.call(1,2)

### upgrade:

truffle(development)> var proxyInstanceUpgraded = await ArithmeticProxy.deployed()
proxyInstanceUpgraded.upgradeTo('1','0x94998fC798F3B9F97e59D0b789AfA2423079
BCc5')
var proxInstUpg = await ArithmeticAdvanced.at(ArithmeticProxy.address)



### Misc:

- Confusion:

```
What I understood is that one should send a transaction at Proxy contract (configured with the latest version of the contract) sending as msg.data the method of the upgradable contract that I want to execute.
```

- Answer:

```
No, that is not the case. You should call you contract as usual using web3, but swapping contract address with proxy address. Example:
```

```js
const proxyInstance = await Arithmetic.at(ArithmeticProxy.address);
```

OR

```js
const proxyInstance = mainContract.at('proxyContractAddress')
```

Aside that, it is as usual as typical truffle/react/web3/solidity project.

- https://blog.gnosis.pm/solidity-delegateproxy-contracts-e09957d0f201