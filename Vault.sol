// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract VaultApp{

    address public owner;

    struct locker{
        uint256 value;
        uint256 time_locked;
    }

    uint256 counter = 0;
    mapping (uint256 => locker) public  Vault;

    modifier OnlyOwner(){
        require(msg.sender == owner,"Can't touch this");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function deposit(uint256 _time)
    public 
    payable 
    OnlyOwner
    {
        counter += 1;
        Vault[counter].time_locked = _time;
        Vault[counter].value = msg.value;
    }

    function withdraw(uint _lockerNumber)
    public
    OnlyOwner
    {
        require(block.timestamp >= Vault[_lockerNumber].time_locked,"Come back Later On");
        payable(owner).transfer(Vault[_lockerNumber].value);
    }

}