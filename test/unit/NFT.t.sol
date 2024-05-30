//SPDX-License_identifier: MIT

pragma solidity ^0.8.16;

import {Test,console} from "../../lib/forge-std/src/Test.sol";
import {NFT} from "../../src/NFT.sol";

contract nftTest is Test {

NFT nft;

address USER = makeAddr("user");
address receiver = makeAddr("receiver");

uint256 public constant STARTING_BALANCE=1 ether;
    function setUp() external {
        nft = new NFT();
        vm.deal(USER,STARTING_BALANCE);
    }  
    

function testmint() public {
    vm.prank(USER);
    uint256 nftId = nft.mint("pudgy","pudypengiuns");    
    (string memory _name, string memory _description, address _owner)= nft.queryNFT(nftId);
    assertEq(_name,string("pudgy"));
    assertEq(_description,string("pudypengiuns"));
    assertEq(_owner,address(USER));    
    assert(nftId==1);
}

function testNFTidIsZero() public{
    vm.prank(USER);
    vm.expectRevert();
    nft.queryNFT(0);
}
function testNFTIDIsValid() public{
    vm.prank(USER);
    uint256 nftId= nft.mint("pudgy","pudypengiuns");
    (string memory _name, string memory _description, address _owner)= nft.queryNFT(nftId);
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

function testTransfer() public {
    vm.startPrank(USER);
    uint256 nftId = nft.mint("MAYC", "MAYC#1-Mutant");
    (, , address _owner) = nft.queryNFT(nftId);
    console.log("Current Owner of NFT is :",_owner);
    nft.transfer(receiver, nftId);
    (,,  _owner) = nft.queryNFT(nftId);
    console.log("Current Owner of NFT is :",_owner);
    assert(address(receiver)==_owner);
    vm.stopPrank();

}


function testNFTisDeletedfromwalletofOldowner() public{
    vm.startPrank(USER);
    uint256 nftId = nft.mint("BAYC", "BAYC#1-LuCKY");
    (,, address _owner) = nft.queryNFT(nftId);
    console.log("Owner of the NFT before Transfer: ", _owner);
    nft.transfer(receiver, nftId);
    (,,  _owner) = nft.queryNFT(nftId);
    console.log("New Owner of NFT is :",_owner);
    vm.expectRevert();
    assert(address(USER)==_owner);
    vm.stopPrank();
}


function testMintAndTransfer() public {
    // USER mints an NFT
    vm.startPrank(USER);
    uint256 nftId = nft.mint("Example NFT", "A unique example NFT");

    // Check initial owner is USER
    (string memory name, string memory description, address _owner) = nft.queryNFT(nftId);
    assertEq(name, "Example NFT", "Name mismatch");
    assertEq(description, "A unique example NFT", "Description mismatch");
    assertEq(_owner, USER, "Initial owner is incorrect");

    // USER transfers the NFT to someoneelse
    nft.transfer(receiver, nftId);

    // Check owner has been updated to Bob
    (name, description, _owner) = nft.queryNFT(nftId);

    assertEq(_owner, receiver, "Owner after transfer is incorrect");
    vm.stopPrank();
}



}