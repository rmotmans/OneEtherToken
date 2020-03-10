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

  mapping(address => address[]) private _possibleSharedAccounts
  mapping(address => address[]) private _sharedAccounts;

  //Contructor
  constructor() public {
      symbol = "OneEth";
      name = "OneEther";
      decimals = 18;
      _totalSupply = 0;
  }

  //function to accept ether and give the same amount of OneEth
  fallback() external payable{
    _balances[msg.sender].add(msg.value);
    _totalSupply += msg.value;
  }

  //function to trade the token back to Ether
  function retrieveEther(uint256 amount) public returns (bool) {
      require(amount <= _balances[msg.sender], "Value exceeding balance");
      _balances[msg.sender] = _balances[msg.sender].sub(amount, "ERC20: transfer amount exceeds balance");
      _totalSupply -= amount;
      msg.sender.transfer(amount);
      return true;
  }

  //function to share account with other address
  function shareAccount(address addressToShare) public returns (bool) {
    //check if address is already between the shared addresses
    bool alreadyInShared = _inAddressArray(_sharedAccounts[msg.sender], addressToShare);
    require(!alreadyInShared, 'address already shares account');
    //check if address is already between the possible shared addresses
    bool alreadyInPossibleShared = _inAddressArray(_possibleSharedAccounts[msg.sender], addressToShare);
    require(!alreadyInPossibleShared, 'address already a possible shared account');
    //check if u are between their possible shared addresses
    bool uAreThereShared = _inAddressArray(_sharedAccounts[addressToShare], msg.sender);

    if (uAreThereShared){
      
    } else {

    }

  }

  //function to get the addresses u want to share an account with
  function getPossibleSharedAccounts() public returns (address[]) {

  }

  //function to get the addresses u do share an acount with
  function getSharedAccounts() public returns (address[]) {

  }

  //function to get total supply
  function totalSupply() public view override returns (uint256) {
      return _totalSupply;
  }

  //get the token balance of a certain user
  function balanceOf(address tokenOwner) public view override returns (uint256 balance) {
          return _balances[tokenOwner];
  }

  //transfer function
  function transfer(address recipient, uint256 amount) public override returns (bool) {
      _transfer(msg.sender, recipient, amount);
      return true;
  }

  //allowance function
  function allowance(address owner, address spender) public view override returns (uint256) {
      return _allowances[owner][spender];
  }

  //approve function
  function approve(address spender, uint256 amount) public override returns (bool) {
      _approve(msg.sender, spender, amount);
      return true;
  }

  //transferFrom function
  function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
      _transfer(sender, recipient, amount);
      _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
      return true;
  }

  //increase allowances
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
      _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
      return true;
  }

  //decrease allowance
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
      _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
      return true;
  }

  //internal transfer function
  function _transfer(address sender, address recipient, uint256 amount) internal {
      require(sender != address(0), "ERC20: transfer from the zero address");
      require(recipient != address(0), "ERC20: transfer to the zero address");

      _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
      _balances[recipient] = _balances[recipient].add(amount);
      emit Transfer(sender, recipient, amount);
  }

  //internal approve function
  function _approve(address owner, address spender, uint256 amount) internal virtual {
      require(owner != address(0), "ERC20: approve from the zero address");
      require(spender != address(0), "ERC20: approve to the zero address");

      _allowances[owner][spender] = amount;
      emit Approval(owner, spender, amount);
  }

  //in array function
  function _inAddressArray(address[] addressArray, address addressToCheck) internal returns (bool) {
    for (uint index = 0; index < addressArray.length; index++){
      if (addressArray[index] == addressToCheck){
        return true;
      }
    }
    return false;
  }
}
