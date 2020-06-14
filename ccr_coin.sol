pragma solidity >=0.4.22 <0.7.0;

pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract CCRToken is ERC20 {
    uint256 storeCount = 0;

    struct Driver {
        string name;
        string cpf;
        string password;
    }

    struct StoreItem {
        string name;
        uint152 price;
        string imageUrl;
        string description;
    }

    struct StoreVoucher {
        string name;
        uint152 price;
        string imageUrl;
        string description;
    }

    struct Store {
        uint256 id;
        string name;
        string storeType;
        string rating;
        string imageUrl;
        string description;
        string location;
        string telefone;
    }
    
    struct StoreRelationship {
        uint256 id;
        StoreItem[] items;
        StoreVoucher[] vouchers;
    }

    mapping(string => Driver) private drivers;
    mapping(uint256 => Store) private stores;
    mapping(uint256 => StoreRelationship) private storeRelationships;

    constructor() public ERC20("CCRCoins", "CCR") {
        _mint(msg.sender, 100000000000000000000000000);
    }

    function sendCoins(address receiver, uint256 amount) external returns (bool success){
        transferFrom(msg.sender, receiver, amount);
        return true;
    }

    function myBalance() public view returns (uint256 balance) {
        return balanceOf(msg.sender);
    }

    // Sign and SignUp truck driver
    function login(string memory cpf, string memory password) public view returns (bool sucess) {
        // if(keccak256(drivers[cpf].password) == keccak256(password)) {
        if (keccak256(bytes(drivers[cpf].password)) == keccak256(bytes(password))) {
            return true;
        } else {
            return false;
        }
    }
    function cadastrar(string memory name,string memory cpf,string memory password) external returns (bool success) {
        drivers[cpf] = Driver(name, cpf, password);
        return true;
    }

    // Insert Store 
    function insertStore(
        string memory name,
        string memory storeType,
        string memory rating,
        string memory imageUrl,
        string memory description,
        string memory location,
        string memory telefone) external returns (bool success) {
        
        stores[storeCount] = Store(
            storeCount,
            name,
            storeType,
            rating,
            imageUrl,
            description,
            location,
            telefone
        );
        // storeRelationships[storeCount] = StoreRelationship(
        //     storeCount,
        //     "",
        //     ""
        //     );
        
        storeCount = storeCount + 1;
        return true;
    }  
    
    function insertStoreItem(uint256 id, string memory itemName, uint152  itemPrice, string memory imageUrl, string memory description) external returns (bool success) {
        storeRelationships[id].items.push(StoreItem(itemName, itemPrice, imageUrl, description));
        return true;
    }
    function insertVoucherItem(uint256 id, string memory itemName, uint152  itemPrice, string memory imageUrl, string memory description) external returns (bool success) {
        storeRelationships[id].vouchers.push(StoreVoucher(itemName, itemPrice, imageUrl, description));
        return true;
    }
    
    function getStore(uint256 id)  public view returns (Store memory){
        return stores[id];
    }
    function getStoreItems(uint256 id)  public view returns (StoreItem[] memory){
        return storeRelationships[id].items;
    }
    function getStoreVouchers(uint256 id)  public view returns (StoreVoucher[] memory){
        return storeRelationships[id].vouchers;
    }
}
