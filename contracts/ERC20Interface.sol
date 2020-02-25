pragma solidity ^0.6.0;

interface ERC20Interface {
    function totalSupply() view external returns (uint);
    function balanceOf(address tokenOwner) view external returns (uint balance);
    function allowance(address tokenOwner, address spender) view external returns (uint remaining);
    function transfer(address to, uint256 tokens) external returns (bool success);
    function approve(address spender, uint256 tokens) external returns (bool success);
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
