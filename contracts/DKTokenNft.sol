//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract DKToken1155 is ERC1155{
    address public owner;
    uint256 private tokenTypeId;
    constructor() ERC1155("uri") {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender,"err : not the owner");
        _;
    }

    function generateToken(address _to, uint256 _amount) public onlyOwner{
        _mint(_to, tokenTypeId, _amount, "");
        tokenTypeId++;
    }   
    
    function generateMultipleToken(address _to, uint256[] memory _amounts) public onlyOwner{
        uint256[] memory  _ids = new uint256[](_amounts.length);
        for(uint256 i=0;i<_amounts.length;i++){
            _ids[i] = tokenTypeId++;
        }

        console.log(_ids.length);

        _mintBatch(_to, _ids, _amounts, "");
        tokenTypeId++;
    }   
}
