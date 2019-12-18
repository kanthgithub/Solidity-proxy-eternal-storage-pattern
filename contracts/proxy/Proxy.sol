pragma solidity ^0.5.1;

contract Proxy {
 function implementation() public view returns (address);

  function() external payable  {
    address _impl = implementation();
    require(_impl != address(0),'owner cannot set itself as the implementation address');
    bytes memory data = msg.data;
    assembly {
      let ptr := mload(0x40)

      // (1) copy incoming call data
      calldatacopy(ptr, 0, calldatasize)

      // (2) forward call to logic contract
      let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
      let size := returndatasize

      // (3) retrieve return data
      returndatacopy(ptr, 0, size)

      // (4) forward return data back to caller
      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }
}