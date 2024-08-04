// SPDX-License-Identifier: MIT
	pragma solidity >=0.8.0 <0.9.0;
	
	/**
	 * @title StorageX
	 * @dev This contract allows storing a value and retrieving it multiplied by 5.
	 */
	contract StorageX {
	
	    uint256 number;
	
	    /**
	     * @dev Store value in variable
	     * @param num value to store
	     */
	    function set(uint256 num) public {
	        number = num;
	    }
	
	    /**
	     * @dev Return value multiplied by 5
	     * @return value of 'number'
	     */
	    function get() public view returns (uint256) {
	        // Solidity 0.8.x automatically checks for overflow.
	        uint256 result = number * 5;
	
	        // Additional check to ensure no overflow occurred.
	        require(result / 5 == number, "Overflow occurred");
	
	        return result;
	    }
	}