const arithmeticSuperAdvanced = artifacts.require('../contracts/ArithmeticSuperAdvanced');

module.exports = async function(deployer, networks, accounts) {
 
  deployer.deploy(arithmeticSuperAdvanced).then(async a => {
    console.log('arithmeticSuperAdvanced contract is deployed : '+a.address);
    let con = new web3.eth.Contract(a.abi, a.address, { address: a.address });
    const arithmeticSuperAdvancedAddress = a.address;
    console.log('deployed arithmeticSuperAdvanced with address: '+arithmeticSuperAdvancedAddress);
    const constructorData = con.methods.initialize('ArithmeticSuperAdvanced').encodeABI();
    console.log('deployed arithmeticSuperAdvanced with constructor data: '+constructorData);
    });
};