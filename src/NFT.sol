//SPDX-License_identifier: MIT




pragma solidity ^0.8.16;

contract NFT {

// Struct to store information about the NFT Token
struct NftToken {
       string name;
       string description;
       address owner; 
}

// This mapping will map an Id of type uint256 with NftToken to uniquely identify it
mapping(uint256=>NftToken) private nftTokens;

// This mapping will map an addres to an array of NFT ids owned by a particular user/address
mapping(address=>uint256[]) private nftOwnerTokens;

// Everytime we create a new NFT we will increment this counter and use it as nft token Id
uint256 nftCounter = 1; 

function mint(string memory _name, string memory _description) public  returns(uint256) {
    NftToken memory nftToken = NftToken(_name,_description,msg.sender);
    nftTokens[nftCounter]=nftToken;
    nftOwnerTokens[msg.sender].push(nftCounter);
    nftCounter++;
    return nftCounter-1;

}
 
function queryNFT(uint256 nftTokenId) public view returns(string memory _name, string memory _description,address _owner)
    {
        require(nftTokenId>=1&&nftTokenId<nftCounter,"Please Pass Valid nft ID");
        NftToken memory newNFT= nftTokens[nftTokenId];
        _name= newNFT.name;
        _description= newNFT.description;
        _owner= newNFT.owner;
        return (_name, _description, _owner);


}


function deletebyNFTtokenId(address account, uint256 nftTokenId) internal {
    //Storing all the NFT ids from a specific address to an array
    uint256[] storage accountsNFTlist = nftOwnerTokens[account];
    for (uint256 i = 0; i < accountsNFTlist.length; i++) {
            if(accountsNFTlist[i]==nftTokenId){
                accountsNFTlist[i] = accountsNFTlist[accountsNFTlist.length-1];
                accountsNFTlist.pop;
            }
            break;
    }

}

function transfer(address receiver, uint256 nftTokenId) public{

    require(msg.sender!=address(0),"Invalid recipient");
    require(nftTokenId>=1&&nftTokenId<nftCounter,"Invalid token ID");
    NftToken storage nftToken = nftTokens[nftTokenId];
    require(msg.sender==nftToken.owner,"You are not the owner");
    nftToken.owner=receiver;
    deletebyNFTtokenId(msg.sender,nftTokenId);
    nftOwnerTokens[receiver].push(nftTokenId);
}


function getNFTByAddress(address owner_Addr) public view returns(uint256[] memory) {

    return nftOwnerTokens[owner_Addr];
    }



}