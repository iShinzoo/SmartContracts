// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract BankingApp{

    struct Account{
        address owner;
        uint256 balance;
        uint256 accountCreatedAt;
    }

    mapping (address => Account) public ChildrenBank;

    event balanceAdded(address owner,uint256 balance,uint256 timestamp);
    event withdrawlDone(address owner,uint256 balance,uint256 timestamp);

    modifier minimum(){
        require(msg.value >= 1 ether,"Does not follow minimum balance crieteria");
        _;
    }

    function accountCreated()
    public  
    payable 
    minimum
    {
        ChildrenBank[msg.sender].owner = msg.sender;
        ChildrenBank[msg.sender].balance = msg.value;
        ChildrenBank[msg.sender].accountCreatedAt = block.timestamp;
        emit balanceAdded(msg.sender,msg.value,block.timestamp);
    }

    function deposit()
    public 
    payable 
    {
        ChildrenBank[msg.sender].balance += msg.value;
        emit balanceAdded(msg.sender,msg.value,block.timestamp);
    }

    function withdrawl()
    public 
    payable 
    {
        payable(msg.sender).transfer(ChildrenBank[msg.sender].balance);
        ChildrenBank[msg.sender].balance = 0;
        emit withdrawlDone(msg.sender,ChildrenBank[msg.sender].balance,block.timestamp);
    }

}