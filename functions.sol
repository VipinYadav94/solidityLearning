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
        ( ,bool b) = returnMany();  //when you only want 2nd output
    }
}


contract Struct {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping (address => Car[]) public carsByOwner;

    function example() external {
        // diff way of intilizing struct
        Car memory Jaguar = Car("Jaguar", 2022, msg.sender);
        Car memory Ghost = Car({model: "Rolls Royce", year: 2021, owner: msg.sender});
        Car memory tesla;
        tesla.model = "Y";
        tesla.year = 2022;
        tesla.owner =  msg.sender;

        cars.push(Jaguar);
        cars.push(Ghost);
        cars.push(tesla);

        cars.push(Car("BMW", 2021, msg.sender));

        Car storage _car = cars[0];
        _car.year = 2020;// it will update the value thats why we used storage insted of memory
        delete _car.owner;// it will delete the value and set it to default value here it is o address

        delete cars[1];// everything will be set to default value
    }
}

// ENUM
contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected
    }

    Status public status;
    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;
    function get() view returns Status {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    // for updating
    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status;
    }
}

// storage, memory and calldata
contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function g(uint[] memory _arr) public returns (uint[] memory) {
        // do something with memory array
    }

    function h(uint[] calldata _arr) external {
        // do something with calldata array
    }
}