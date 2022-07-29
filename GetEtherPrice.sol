// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract GetEtherPrice {
    address constant PRICE_ADDRESS = 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e;
    AggregatorV3Interface internal priceFeed;

    constructor() {
        priceFeed = AggregatorV3Interface(PRICE_ADDRESS);
    }

    function getEtherPrice() public view returns(
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ) {
        (roundId, answer, startedAt, updatedAt, answeredInRound) = priceFeed.latestRoundData();
    }
}
