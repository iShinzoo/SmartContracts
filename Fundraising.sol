// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract FundsRaisingApp{

    address public owner;
    uint256 public goal;
    uint256 public totalRaised;

    mapping (address => uint256) public Donations;

    event Donated(address indexed donor,uint256 amount);
    event Withdrawn(uint256 amount);

    modifier OnlyOwner(){
        require(msg.sender == owner,"Only Owner can call this function");
        _;
    }

    constructor(uint256 _goal){
        owner = msg.sender;
        goal = _goal;
    }

    function donate(uint256 amount)
    external 
    payable 
    {
        require(msg.value == amount, "Mismatch between amount and msg.value");
        require(msg.value > 0,"Donation amount should be greater than 0");
        Donations[msg.sender] += msg.value;
        totalRaised += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    function withdraw()
    external 
    OnlyOwner
    {
        require(totalRaised >= goal,"Fundraising Goal not met yet");
        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);
        emit Withdrawn(amount);
    }

    function getBalance()
    external 
    view 
    returns(uint256)
    {
        return address(this).balance;
    }

}