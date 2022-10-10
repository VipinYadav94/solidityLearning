// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WalletEatherTransfer {
    address payable public owner;

    constructor() {
        owner=payable(msg.sender);
    }

    receive () external payable{}

    function send(uint _amount) external {
        require(msg.sender==owner, "caller is not owner");
        // owner.transfer(_amount);
        // to save gas we replace state variable with variables for above line like
        payable(msg.sender).transfer(_amount);
    } 

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

}