// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract DonationsApp{

    event donated(address indexed donor, uint256 amount);

    event withdrawn(uint256 amount);

    address public owner;

    uint256 public totalDonations;

    mapping(address => uint256) public donations;

    modifier OnlyOwner(){
        require(msg.sender == owner,"Only owner can call this function");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function donate()
    external 
    payable 
    {
        require(msg.value > 0,"Amount should be greater than 0");
        totalDonations += msg.value;
        donations[msg.sender] += msg.value;

        emit donated(msg.sender, msg.value);
    }

    function withdraw()
    external 
    OnlyOwner
    {
        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);
        emit withdrawn(amount);
    }

    function checkBalance()
    external 
    view 
    returns(uint256)
    {
        return address(this).balance;
    }

}