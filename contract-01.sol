// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title StorageX
 * @dev Store & return variable x 5
 */

contract StorageX {

    uint number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function set(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value *5
     * @return value of 'number'
     */
    function get() public view returns (uint256){
        return number*5;
    }

}