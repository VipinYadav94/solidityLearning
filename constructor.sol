// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// constructor are spacial function that are only called once when contract is deployed
// mainly used to initlize state variables

contract Constructor {
    address public owner;
    uint public x;

    constructor(uint _x) {
        owner = msg.sender;
        x = _x;
    }
}

// creating a contract what we have learned

contract Ownalble {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCall() external view onlyOwner returns(address) {
        // code
        return owner;
    }

    function anyoneCanCall() external view returns(address){
        // code
        return msg.sender;
    }
}