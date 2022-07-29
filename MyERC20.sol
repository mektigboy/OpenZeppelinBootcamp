// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {
    constructor() ERC20("MyToken", "MT") {
        _mint(address(this), 1000 * 1e18);
        _mint(msg.sender, 1000 * 1e18);
    }
}
