// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IsSaleToken {
    function setSale(address _sale) external;

    function mint(address to, uint256 amount) external;
}

contract TokenSale is Ownable {
    IsSaleToken public immutable token;
    uint256 public rate;
    uint64 public start;
    uint64 public end;
    uint256 public hardCapWei;

    constructor(
        address _token,
        uint256 _rate,
        uint64 _start,
        uint64 _end,
        uint256 _hardCapWei,
        address _initialOwner
    ) Ownable(_initialOwner) {
        token = IsSaleToken(_token);
        rate = _rate;
        start = _start;
        end = _end;
        hardCapWei = _hardCapWei;
        token.setSale(address(this));
    }

    function buy() external payable {
        _buy(msg.sender);
    }

    function _buy(address buyer) internal {
        require(block.timestamp >= start && block.timestamp <= end, "Sale not active");
        require(msg.value > 0, "Must send ETH to buy tokens");
        uint256 tokensToMint = msg.value * rate;
        token.mint(buyer, tokensToMint);
    }

    function withdraw() external onlyOwner {
        require(block.timestamp > end, "Sale not ended");
        (bool success, ) = payable(owner()).call{value: address(this).balance}("");
        require(success, "withdraw failed");
    }
}
