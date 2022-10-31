// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SelfDestructBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(owner == msg.sender, "not owner");
        emit Withdraw(address(this).balance );
        selfdestruct(payable(msg.sender));
    }
}