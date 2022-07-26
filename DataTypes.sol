// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract DataTypes {
    // State variables.
    uint8 num1;
    uint256 num2;
    int256 withSign;
    uint256 public timestamp;

    bytes32 public myBytes1;
    bytes2 myBytes2 = 0x0000;
    bytes public myBytes3;

    address public myContract;
    address public owner;

    bool public success = true;
    bool public myBool;

    struct Person {
        string firstName;
        bytes8 lastName;
        bool married;
    }

    // Key => Value
    mapping(address => person) public mapping1;
    mapping(uint256 => bool) public mapping2;

    constructor () {
        owner = msg.sender;
        timestamp = block.timestamp;
    }

    function registerPerson(string memory _firstName, bytes8 _lastName) public {
        persons[msg.sender].firstName = _firstName;
        persons[msg.sender].lastName = _lastName;
    }

    function sum(uint256 _a, int256 _b) public pure returns(uint256) {
        uint256 x = 10000;
        return _a + uint256(_b) + x;
    }
}
