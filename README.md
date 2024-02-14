---
title: Proof of Knowledge On-Chain
mail: pandiajason@gmail.com
author: Jason Pandian
symbol: NTT
EVM: Yes
started date: 17-12-2022
completed date: 10-10-2023
---

# Proof-of-Knowledge-On-Chain
Implementation of Non-Transferable-Non Fungible Tokens using Non-Fungible Tokens.

## Simple Summary

A standard interface for non-transferable-non-fungible tokens, also known as NTNFTs aka NTTs(For Proof of Knowledge On Chain).

## Abstract

The following standard allows for the implementation of a standard API for NTTs within smart contracts. This standard provides functionalities to track and mint NTTs with MultiSig-registry with Zero Knowledge Proof extention. It can be implemented in knowledge credentials management systems.

We considered use cases of NTTs being issued by authentic authorities("issuers/operators") to individuals("users"). NTTs can represent ownership over authentic digital assets with following properties:

- Non Fungible property — unique identities, credientials,
- No Value — authentic tokens with no monetry value,
- "Trust Minimization" Economy — Open, Transperent and Secured On-Chains.

In general, all human credentials are distinct and no two credential are alike. NTTs are *distinguishable* and you must track the ownership of each one separately.

## Motivation

A standard interface allows web applications to work with any NTT on Ethereum(EVM). We provide for simple nttSetup smart contract(starter) as well as contracts that track an *arbitrarily large* number of NTTs.

This standard is inspired by the ERC-721 token standard. It removes the features like 'transfer', 'burn and 'approve' functions, it also redefines the scope of '_mint' function. Finally, this standard can mint tokens by the issuer/operator('msg.sender is the 'onlyOwner') to specific user.


## Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/PandiaJason/Non-Transferable-Non-FungibleTokens/blob/main/contracts/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @dev Implementation of https://github.com/PandiaJason/Non-Transferable-NonFungible-Tokens
 * Non_Transferable Token with MultiSig Scheme
 * {Modified Extension of ERC721}.
 */
contract NTT is ERC721URIStorage, ReentrancyGuard {
    using SafeMath for uint256; // Import SafeMath

    // Immutable nttRECIPIENT address to keep NTT
    address public immutable nttRECIPIENT;

    // Mapping of tokenID => uri
    mapping(uint256 => string) public tokensINFO;

    struct tokenTHRESHOLD {
        uint256 tokenTVAL;
        address[] signedAUTH;
    }

    // Mapping of tokenID => tokenTHRESHOLD
    mapping(uint256 => tokenTHRESHOLD) public tokensTDATA;

    constructor(address _nttRECIPIENT) ERC721("Non-Transferable-Token", "NTT") {
        nttRECIPIENT = _nttRECIPIENT;
    }

    /**
     * @dev Implementation of function uriDATA
     * verifies msg.sender, uri length and set uri
     * return uriDATA {string}
     */
    function uriDATA(uint256 tokenID, string memory uri)
        public
        nonReentrant
        returns (string memory)
    {
        require(registry[msg.sender] == true, "Not an authoritarian");
        require(
            bytes(tokensINFO[tokenID]).length == 0,
            "URI already exists"
        );
        tokensINFO[tokenID] = uri;
        return tokensINFO[tokenID];
    }

    /**
     * @dev Implementation of function mintNTT
     * verifies msg.sender, uri length, tokenTVAL and
     * triggers mint, setTokenURI
     * return tokenID {uint256}
     */
    function mintNTT(uint256 tokenID)
        public
        nonReentrant
        returns (uint256)
    {
        require(
            bytes(tokensINFO[tokenID]).length != 0,
            "URI doesn't exist"
        );
        require(
            tokensTDATA[tokenID].tokenTVAL >= 2,
            "Doesn't meet the threshold"
        );
        _mint(nttRECIPIENT, tokenID);
        _setTokenURI(tokenID, tokensINFO[tokenID]);

        return tokenID;
    }

    /**
     * @dev Implementation of function multiSIG
     * verifies msg.sender, uri length, isAuthAlreadySigned and
     * appends tokenTVAL by 1, & signedAUTH
     */
    function multiSIG(uint256 _tokenID) public nonReentrant {
        require(
            bytes(tokensINFO[_tokenID]).length != 0,
            "URI doesn't exist"
        );
        require(
            registry[msg.sender] == true,
            "Not an authoritarian"
        );
        require(
            isAuthAlreadySigned(_tokenID, msg.sender) == false,
            "AuthAlreadySigned"
        );
        tokensTDATA[_tokenID].tokenTVAL = tokensTDATA[_tokenID].tokenTVAL.add(
            1
        );
        tokensTDATA[_tokenID].signedAUTH.push(msg.sender);
    }

    /**
     * @dev Implementation of function isAuthAlreadySigned
     * struct tokenTHRESHOLD retrieved from the storage
     * iterate the specific tokenTDATA and check signee or not
     * bool return true or false
     */
    function isAuthAlreadySigned(uint256 tokenID, address signee)
        public
        view
        returns (bool)
    {
        tokenTHRESHOLD storage signees = tokensTDATA[tokenID];
        for (uint256 i = 0; i < signees.signedAUTH.length; i++) {
            if (signees.signedAUTH[i] == signee) {
                return true;
            }
        }
        return false;
    }
}


```

This Solidity code defines a contract called 'NTT' that is an implementation of the ERC721 standard for non-fungible tokens. The contract is derived from the 'ERC721URIStorage' contract, which itself implements the ERC721 standard and provides a way to store and retrieve the URI (Uniform Resource Identifier) associated with each token.

The 'NTT' contract also uses the 'Counters' contract from the OpenZeppelin library to maintain a count of the total number of tokens that have been created. It has a public variable called '_tokenIds' that is an instance of the 'Counter' struct defined in the 'Counters' contract.

The contract has a single constructor that takes an address parameter called '_nttHolder' and assigns it to the 'nttHolder' variable. The 'nttHolder' variable is an address type and is marked as 'immutable', which means it cannot be reassigned after the contract is deployed.

The contract also has a public function called 'addNtt', which can be called by the owner("issuer") of the contract to create a new token and associate it with a URI. The function takes a single 'string' parameter called 'tokenURI' and returns a 'uint256' value representing the ID of the new token. The function increments the '_tokenIds' counter, calls the '_mint' function inherited from the 'ERC721' contract to mint a new token, and then calls the '_setTokenURI' function inherited from the 'ERC721URIStorage' contract to set the URI of the new token. It also support MultiSig Registry for blockchain based credential management system[1]

## References

**Standards**
[1] Jason Pandian, "Proof of Knowledge On-Chain", [link](https://github.com/PandiaJason/Proof-of-Knowledge-On-Chain/blob/main/ME%20JASON%20PROJECT%20DOCUMENT-FINAL-POKOC.pdf) 
[2] [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) Token Standard.
[3] [ERC-165](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md) Standard Interface Detection.
[4] [ERC-721](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md) Non-Fungible Token Standard.
