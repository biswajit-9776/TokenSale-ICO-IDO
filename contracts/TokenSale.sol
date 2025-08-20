// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IsSaleToken {
    function setSale(address _sale) external;
    function mint(address to, uint256 amount) external;
}

contract TokenSale {
    
    IsSaleToken public immutable token;
    uint256 public rate;
    uint64 public start;
    uint64 public end;
    uint256 public hardCapWei;

    constructor(address _token, uint256 _rate, uint64 _start, uint64 _end, uint256 _hardCapWei){
        token = IsSaleToken(_token);
        rate = _rate;
        start = _start;
        end = _end;
        hardCapWei = _hardCapWei;
        token.setSale(address(this));
    }

    
}