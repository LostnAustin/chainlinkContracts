// SPDX-License_Identifier: minutes
pragma solidity ^0.6.0;

import './SimpleStorage.sol';

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    
    function sfStore(uint256, _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //need address and ABI
        
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);    
        
    }
}
