// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SaleToken is ERC20, Ownable {
    address public sale;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) Ownable(msg.sender) {}

    function setSale(address _sale) external {
        require(sale == address(0), "Sale already set");
        require(_sale != address(0), "Sale cannot be zero address");
        sale = _sale;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == sale, "Only sale can mint tokens");
        require(to != address(0), "Cannot mint to zero address");
        _mint(to, amount);
    }
}
