// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/PandiaJason/Non-Transferable-Non-Fungible-Tokens/blob/main/contracts/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NTT is ERC721URIStorage {
  using Counters for Counters.Counter;
    Counters.Counter public _tokenIds;

    address public immutable nttHolder;

    struct tokenTHOLD{
        uint256 tokenThresshold;
        address [] signedUser;
    }

    // tokenid => tokenThresshold 
    mapping(uint256 => tokenTHOLD) public thresshold;


    constructor(address  _nttHolder) ERC721("Non-Transferable-Token", "NTT") {
    // constructor(address  _nntHolder, string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        nttHolder = _nttHolder;
    }

    function mintNTT(string memory tokenURI)
        public returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();

        require( thresshold[newItemId].tokenThresshold >= 2, "Doesn't  met the thresshold");
        _mint(nttHolder, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

    function multisig(uint256  _tokenId)
    public  {
        require(registry[msg.sender] == true, "Not an authoritarian" );
        require( isUserAlreadySigned(_tokenId, msg.sender ) == false, "error");
        thresshold[_tokenId].tokenThresshold += 1;
        thresshold[_tokenId].signedUser.push(msg.sender);
            
    }

    function isUserAlreadySigned(uint256 tokenId, address user) 
    public view returns (bool)
    {        
        tokenTHOLD storage users =  thresshold[tokenId];
        for (uint i=0; i< users.signedUser.length; i++){
            if (users.signedUser[i] == user){
            return true;}
        }return false;
    }

}
