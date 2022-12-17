---
title: Non-Transferable-Non-Fungible-Tokens
mail: pandiajason@gmail.com
author: Jason Pandian
symbol: NTT
EVM: Yes
date: 17-12-2022
---

# Non-Transferable-Non-Fungible-Tokens
Implementation of Non-Transferable-Non Fungible Tokens using Non-Fungible Token 

## Simple Summary

A standard interface for non-transferable-non-fungible tokens, also known as NTNFTs or NTTs.

## Abstract

The following standard allows for the implementation of a standard API for NTNFTs within smart contracts. This standard provides basic functionality to track and mint  NTNFTs aka NTTs.

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

import "https://github.com/PandiaJason/Non-Transferable-Non-Fungible-Tokens/blob/main/contracts/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NTT is ERC721URIStorage {
  using Counters for Counters.Counter;
    Counters.Counter public _tokenIds;
    address public immutable nttHolder;

    constructor(address  _nttHolder) ERC721("Non-Transferable-Token", "NTT") {
    // constructor(address  _nntHolder, string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        nttHolder = _nttHolder;
    }

    function addNtt(string memory tokenURI)
        public onlyOwner
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(nttHolder, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

}

```

This Solidity code defines a contract called 'NTT' that is an implementation of the ERC721 standard for non-fungible tokens. The contract is derived from the 'ERC721URIStorage' contract, which itself implements the ERC721 standard and provides a way to store and retrieve the URI (Uniform Resource Identifier) associated with each token.

The 'NTT' contract also uses the 'Counters' contract from the OpenZeppelin library to maintain a count of the total number of tokens that have been created. It has a public variable called '_tokenIds' that is an instance of the 'Counter' struct defined in the 'Counters' contract.

The contract has a single constructor that takes an address parameter called '_nttHolder' and assigns it to the 'nttHolder' variable. The 'nttHolder' variable is an address type and is marked as 'immutable', which means it cannot be reassigned after the contract is deployed.

The contract also has a public function called 'addNtt', which can be called by the owner("issuer") of the contract to create a new token and associate it with a URI. The function takes a single 'string' parameter called 'tokenURI' and returns a 'uint256' value representing the ID of the new token. The function increments the '_tokenIds' counter, calls the '_mint' function inherited from the 'ERC721' contract to mint a new token, and then calls the '_setTokenURI' function inherited from the 'ERC721URIStorage' contract to set the URI of the new token.






## References

**Standards**
1. [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) Token Standard.
1. [ERC-165](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md) Standard Interface Detection.
1. [ERC-721](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md) Non-Fungible Token Standard.
