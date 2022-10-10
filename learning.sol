// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HelloWorld {
    string public muString = "hey you";
    uint public addition = 8 + 4;
    int public minInt = type(int).min;

    int public maxInt = type(int).max;
    bool public boolean = true;
    address public add = 0x8e9bdB199c6331AF1aBf3dD6b870Bbb001545b5f;
    bytes32 public b32 = 0xec7d3169581460c3ca0d3ea0648f6f587ea71c0367fff507d03111b26ffbc5c0;
}