pragma solidity ^0.5.1;

contract UpgradeabilityStorage {

    string internal _version;
    address internal _implementation;

    function version() public view returns(string memory){
        return _version;
    }

    function implementation() public view returns(address){
        return _implementation;
    }
}