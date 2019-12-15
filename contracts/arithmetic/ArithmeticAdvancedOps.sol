pragma solidity ^0.5.1;

import './UpgradeableArithmeticStorage.sol';

contract ArithmeticAdvancedOps is UpgradeableArithmeticStorage {

  string public name;

  function initialize(string memory  _name) public {
    name = _name;
  }

  event CubeEvent(uint256 indexed cube, uint256 a, uint256 b);
  event doubleAdderEvent(uint256 indexed doubleAdderResult, uint256 a, uint256 b);
  event plusSquareEvent(uint256 indexed plussquareResult, uint256 a, uint256 b);

  function pluscube(uint256 a, uint256 b) public returns(uint256) {
    uint256 addresult = a+b;
    uint256 result = addresult * addresult * addresult;
    resultArray.push(result);
    resultmap['pluscube'] = result;
    emit CubeEvent(result,a,b);
    return result;
  }

  function doubleAdder(uint256 a, uint256 b) public returns(uint256) {
      uint256 doubleAdderResult = 2*(a+b);
      resultArray.push(doubleAdderResult);
      resultmap['doubleAdder'] = doubleAdderResult;
      emit doubleAdderEvent(doubleAdderResult, a, b);
      return doubleAdderResult;
  }

  function plussquare(uint256 a, uint256 b) public returns(uint256) {
      uint256 addresult = a+b;
      uint256 plussquareResult = addresult * addresult;
      resultmap['plussquare'] = plussquareResult;
      emit plusSquareEvent(plussquareResult, a, b);
      return plussquareResult;
  }

  function getResult() public view returns(uint256[] memory){
      return resultArray;
  }

  function getResultFromMap(string memory action) public view returns(uint256){
      return resultmap[action];
  }
}