const arithmeticStorageProxy = artifacts.require('../contracts/arithmetic/ArithmeticStorageProxy');
module.exports = async function(deployer, networks, accounts) {
  deployer.deploy(arithmeticStorageProxy).then(async a => {
    console.log('arithmeticStorageProxy contract is deployed : '+a.address);
    let con = new web3.eth.Contract(a.abi, a.address, { address: a.address });
    const arithmeticStorageProxyAddress = a.address;
    console.log('deployed arithmeticStorageProxy with address: '+arithmeticStorageProxyAddress);
    });
};