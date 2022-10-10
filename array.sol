// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// array -dynamic or fixed size
// initilization
// Insert(push), get, update,delete, pop, length
// creating array in memory
// returning array from function
// remove by shifting(not gas efficient)
// remove by replacing(gas efficent)

contract Array {
    uint[] public nums = [1, 2, 3]; //dynamic array
    uint[5] public numsFixed = [1,2,3,4,5]; //fixed size array

    function one() external {
        nums.push(4); //[1,2,3,4]
        uint x = nums[1]; // x will be 2
        nums[2] = 5; //[1,2,5,4]
        delete nums[1]; //[1,0,5,4] delete dosen't completely remove element it resets it to default value 0
        nums.pop(); //[1,0,5]
        uint len = nums.length;

        // create array in memory
        uint[] memory y = new uint[](5); //y is name of array and 5 is length, memory array are fixed size
    }

    function returnArray() external view returns (uint[] memory) {
        return nums;
    }
    // longer the length of array more gas it will use

}

    // [1,2,3] -> remove(1) ,1 is position -> [1,3,3] -> [1,3]
    // shifting indexed right values to left and then poping last
    // [1,2,3,4,5,6] -> remove(2) -> [1,2,4,5,6,6] -> [1,2,4,5,6]
    // [1} -> remove(0) -> []
    // not gas efficent
contract Remove {
    uint[] public arr;
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");

        for(uint i=_index; i<arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
    function test() external {
            arr = [1,2,3,4];
            remove(1);

        }

    // remove by replacing
    // [1,2,3,4,5,6] -> remove(1) -> [1,6,3,4,5]
    function removByReplace(uint _index) public {
            arr[_index] = arr[arr.length - 1];
            arr.pop();

    }
}