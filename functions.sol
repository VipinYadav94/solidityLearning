// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract mathFunctions {
    function addition(uint x, uint y) external pure returns (uint) {
        return x + y;
    }

    function substraction (uint x, uint y) external pure returns (uint) {
        return x - y;
    }
}

contract stateVariable {
    uint public my = 123; //this a state variable which is inside contract and outside function it is stored on blockchain

    function hello() external {
        uint data = 234; //this is local variable this exist when function is called
    }
}

contract localVariable {
    uint public a = 123;
    bool public b;
    address public c;

    function hello() external {
        uint x = 646;
        bool y = false;
        x += 400;
        y = true;

        a = 778;
        b = true;
        c = address(2);
    }
}

contract globalVariable {
    function globalVars() external view returns(address, uint, uint) {
        address sender = msg.sender; //it stores the address of sender who called this function
        uint time = block.timestamp;
        uint blockNumber = block.number;
        return (sender, time, blockNumber);
    }
}

//diff btw view and pure
//view can read data from blockchain and pure dont read anything from blockchain

contract viewAndPure {
    uint public num;

    function viewFun() external view returns(uint) {
        return num;
    }

    function pureFun() external pure returns(uint) {
        return 1;
    }

//example for view func 
    function addNum(uint x) external view returns(uint) {
        return num + x;
    }

    //example for pure func (on fetching any data from blockchain)
    function addNumb(uint x, uint y) external pure returns(uint) {
        return y + x;
    }
}

//for and while loop
// higher the number of loops then it will use more gas
contract Loop {
    function loops() external pure {
        for (uint i = 0; i < 10; i++) {
            // some code
            if (i == 3){
                continue;
                // when i = 3 it will skip the bellow code and run the remaning loop to 9
            }
            // some code
            if (i == 5){
                break;
                // when i = 5 the loop will break and won't run rest loop
            }
            // some code
        }

        uint k = 0;
        while (k < 10) {
            // some code
            k++;
        }
    }

    // sum of n numbers
    function sumOf_n(uint _n) external pure returns(uint) {
        uint s;
        for(uint i=0; i<=_n; i++){
            s += i;
        }
        return s;
    }
}

// types of throwing error require, revert, assert
// in error gas will be refunded and if any variable is changed it will be reverted
// we can create custom error to save gas (custom error only after solidity 0.8)
contract Error {
    function errorRequire(uint a) public pure {
        require(a<=10, "input should be less then  or equal to 10"); //long error msg use more gas
    }
     
    function errorRevert(uint a) public pure {
        if (a>10){
            revert("input should be less then  or equal to 10");
        }
    }

    uint public num = 123;
    function errorAssert() public view {
        assert(num == 123);
        // give boolean result acording to condition
    }

    function demo(uint a) public {
        num += 1;
        // num value will be updated
        require(a<10);
        // it will throw error now it will revert the changes done and gas (num will be 123 now)
    }

    //custom error 
    error MyError(address caller, uint input);
    function customError(uint a) public view {
        if(a>10) {
        revert MyError(msg.sender, a);
        }
    }
}

// function modifier is reuse code befor or after function
// types basic, input, sandwich
contract Modifier {
    bool public paused;
    uint public count;

    function setPause( bool _paused) external {
        paused = _paused;
    }

    modifier whenNotPaused() {
        require(!paused, "paused");
        _; //it tells solidity to call actual function that this modifier function wraps
    }

    function inc() external whenNotPaused {
        count +=1;
    }
    function dec() external whenNotPaused {
        count -=1;
    }

    // input modifier
    modifier cap (uint _x) {
        require(_x>100, "x > 100");
        _;
    }
    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    // sandwich modifier
    modifier sandwich() {
        //some code
        count +=10;
        _;
        // some code
        count *=2;
    }

    function sandwichModifier() external sandwich {
        count +=1;
    }
}

// returning multiple outputs , named outputs and destructuring assignment

contract FunctionOutputs {
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    function assigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    function destructuringAssigment() public pure {
        (uint x, bool b) = returnMany();  //assigning output from a function to variable
        (,bool b) = returnMany();  //when you only want 2nd output
    }
}
