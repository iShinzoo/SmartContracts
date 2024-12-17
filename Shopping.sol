// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract ShoppingApp{

    struct Item{
        uint256 id;
        address payable seller;
        string name;
        uint256 price;
        bool isSold;
    }

    uint256 public itemCount = 0;
    mapping (uint256 => Item) public items;

    event ItemListed(uint256 indexed itemId, address indexed seller, string name, uint256 price);
    event ItemPurchased(uint256 indexed itemId, address indexed buyer, address indexed seller, uint256 price);

    function listItem(string memory _name, uint256 _price)
    external 
    {
        require(bytes(_name).length > 0,"Item name is required");
        require(_price > 0,"Price Should be greater than 0");

        itemCount++;
        items[itemCount] = Item(itemCount,payable(msg.sender),_name,_price,false);

        emit ItemListed(itemCount, msg.sender, _name, _price);
    }

    function buyItem(uint256 _itemId)
    external 
    payable 
    {
        Item storage item = items[_itemId];
        require(item.id == _itemId,"Item does not exist");
        require(msg.value == item.price,"Incorrect ether sent");
        require(!item.isSold,"Item already sold");
        require(msg.sender != item.seller,"Seller cannot buy thier own item");

        item.isSold = true;
        item.seller.transfer(msg.value);

        emit ItemPurchased(_itemId, msg.sender, item.seller, item.price);
    }

}
    
