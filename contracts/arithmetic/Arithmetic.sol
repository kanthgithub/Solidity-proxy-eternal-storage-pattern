pragma solidity ^0.5.1;

import './UpgradeableArithmeticStorage.sol';

contract Arithmetic is UpgradeableArithmeticStorage {

    event addEvent(uint256 indexed sum, uint256 a, uint256 b);
    event subtractEvent(uint256 indexed substract, uint256 a, uint256 b);
     string public name;

     function initialize(string memory  _name) public {
        name = _name;
    }

    function add(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a+b;
        resultArray.push(result);
        resultmap['add'] = result;
        emit addEvent(result,a,b);
        return result;
    }

    function subtract(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a-b;
        resultArray.push(result);
        resultmap['subtract'] = result;
        emit subtractEvent(result,a,b);
        return result;
    }


    function div(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a/b;
        resultArray.push(result);
        resultmap['div'] = result;
        return result;
    }


    function multiply(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a*b;
        resultArray.push(result);
        resultmap['multiply'] = result;
        return result;
    }


    function doubleAdder(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = 2*(a+b);
        resultArray.push(result);
        resultmap['doubleAdder'] = result;
        return result;
    }

    function plussquare(uint256 a, uint256 b) public returns(uint256) {
        uint256 addresult = a+b;
        uint256 result = addresult * addresult;
        resultmap['plussquare'] = result;
        return result;
    }

    function getResult() public view returns(uint256[] memory){
        return resultArray;
    }

    function getResultFromMap(string memory action) public view returns(uint256){
        return resultmap[action];
    }
}
