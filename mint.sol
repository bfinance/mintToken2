pragma solidity ^0.6.10;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MintableToken is AccessControl, ERC20 {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() public ERC20("Gold", "GLD") {
        // Grant the contract deployer the MINTER_ROLE
        _setupRole(MINTER_ROLE, msg.sender);
    }

    function mint(address account, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not the owner");
        _burn(account, amount);
    }

    function grantMinterRole(address minterAddress) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not an admin");
        grantRole(MINTER_ROLE, minterAddress);
    }

    function revokeMinterRole(address minterAddress) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not an admin");
        revokeRole(MINTER_ROLE, minterAddress);
    }
}
