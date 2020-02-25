pragma solidity ^0.6.0;

import './SafeMath';
import './ERC20Interface';

contract OneEtherToken is ERC20Interface{

  using SafeMath for uint;

  string public symbol;
  string public  name;
  uint8 public decimals;

  uint256 private _totalSupply;

  mapping(address => uint256) private _balances;
  mapping(address => mapping(address => uint256)) private _allowances;

  //Contructor
  constructor() public {
      symbol = "OneETH";
      name = "OneEther";
      decimals = 18;
      _totalSupply = 0;
  }


  fallback() external payable{
    _balances[msg.sender] = msg.value;
    _totalSupply += msg.value;
  }
}
