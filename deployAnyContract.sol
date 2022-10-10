// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Proxy {
    event Deploy(address);

    receive() external payable {}

    function deploy(bytes memory _code) external payable returns (address addr) {
        assembly {
            // what is v, p, n
            // v is amount of ETH to send
            // p is pointer in memory to start of code
            // n is size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
            // callvalue is amount of eather to send to contract to deploy(v)
            // 0x20 is equal to 32 in hexadecimal
            // mload is 32 size
            // := is shorthand method equal to defining adrress addr; & then returning it return addr;
        }
        // if contract fails to deploy it return address 0 on error
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract Contract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }
}

contract Contract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(Contract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint _x, uint _y) external pure returns (bytes memory) {
        bytes memory bytecode = type(Contract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}