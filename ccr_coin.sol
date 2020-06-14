pragma solidity ^0.6.0;

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
    }

    struct StoreVoucher {
        string name;
        uint152 price;
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
        StoreItem[] items;
        StoreVoucher[] vouchers;
    }

    mapping(string => Driver) private drivers;
    mapping(uint256 => Store) private stores;

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

    // Store
    function insertStore() external returns (bool success) {

    }
}
