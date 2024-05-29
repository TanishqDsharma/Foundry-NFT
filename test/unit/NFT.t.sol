//SPDX-License_identifier: MIT

pragma solidity ^0.8.16;

import {Test,console} from "../../lib/forge-std/src/Test.sol";
import {NFT} from "../../src/NFT.sol";

contract nftTest is Test {

NFT nft;

address USER = makeAddr("user");

uint256 public constant STARTING_BALANCE=1 ether;
    function setUp() external {
        nft = new NFT();
        vm.deal(USER,STARTING_BALANCE);
    }       

function testmint() public{
    vm.prank(USER);
    console.log(USER);
     uint256 ID= nft.mint("pudgy","pudypengiuns");
     console.log("ID is :", ID);
    uint256[] memory nftId = nft.getNFTByAddress(USER);
    (string memory _name, string memory _description, address _owner)= nft.queryNFT(1);

    assert(nftId[0]==1);
    assert(address(USER)==_owner);
}

function testNFTidIsZero() public{
    vm.prank(USER);
    vm.expectRevert();
    nft.queryNFT(0);
}
function testNFTIDIsValid() public{
    vm.prank(USER);
    console.log(USER);
    uint256 ID= nft.mint("pudgy","pudypengiuns");
    console.log("ID is :", ID);
    (string memory _name, string memory _description, address _owner)= nft.queryNFT(1);
    assertEq(_name,string("pudgy"));
    assertEq(_description,string("pudypengiuns"));
    assertEq(_owner,address(USER));
    
}

function testgetNFTbyAddress() public{
    for(uint256 i=0;i<5;i++){
        vm.prank(USER);
        nft.mint("pudgy","pudypengiuns");
    }

    uint256[] memory alltokens = nft.getNFTByAddress(USER);
    
    // Checking alltokens array has all 5 minted NFTs 
    assert(alltokens.length == 5);  
}

function testNFTisDeleted() public{
    vm.prank(USER);
    console.log(USER);

    nft.mint("BAYC", "BAYC#1-LuCKY");
    (string memory _name, string memory _description, address _owner) = nft.queryNFT(1);
    console.log("Name :",_name);
    console.log("Description :",_description);
    console.log("Owner:",_owner);
    
}

}