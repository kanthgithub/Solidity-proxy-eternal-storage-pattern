pragma solidity ^0.5.1;

import './Proxy.sol';
import './UpgradeabilityStorage.sol';

contract UpgradeabilityProxy is Proxy, UpgradeabilityStorage {
  event Upgraded(string version, address indexed implementation);
  function upgradeTo(string memory version, address implementation) public {
    require(_implementation != implementation, 'cannot use existing implementation for upgrade');
    _version = version;
    _implementation = implementation;
    emit Upgraded(version, implementation);
  }

  function getImplementation() public view returns(address){
    return implementation();
  }

}