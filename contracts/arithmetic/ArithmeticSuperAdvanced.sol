pragma solidity ^0.5.1;

import './UpgradeableArithmeticStorage.sol';
import './Arithmetic.sol';
import './ArithmeticAdvancedOps.sol';

contract ArithmeticSuperAdvanced is Arithmetic, ArithmeticAdvancedOps {

  string public name;

  function initialize(string memory  _name) public {
    name = _name;
  }

  event QuadrapleEvent(uint256 indexed quadraple, uint256 a, uint256 b);

  function plusquadraple(uint256 a, uint256 b) public returns(uint256) {
    uint256 addresult = a+b;
    uint256 result = addresult * addresult * addresult * addresult;
    resultArray.push(result);
    resultmap['plusquadraple'] = result;
    emit QuadrapleEvent(result,a,b);
    return result;
  }
}