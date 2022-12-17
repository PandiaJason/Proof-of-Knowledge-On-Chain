# Non-Transferable-Non-Fungible-Tokens
Implementation of Non-Transferable-Non Fungible Tokens using Non-Fungible Token

## Simple Summary

A standard interface for non-fungible tokens, also known as deeds.

## Abstract

The following standard allows for the implementation of a standard API for NTNFTs within smart contracts. This standard provides basic functionality to track and mint  NTNFTs aka NTTs.

We considered use cases of NTTs being issued by authentic authorities("issuers/operators") to individuals("users"). NTTs can represent ownership over authentic digital assets. We considered a diverse universe of assets, and we know you will dream up many more:

- Non Fungible property — unique identities, credientials
- No Value — authentic tokens with no monetry value
- "Trust Minimization" Economy — Open, Transperent and Secured on chains.

In general, all human credentials are distinct and no two credential are alike. NTTs are *distinguishable* and you must track the ownership of each one separately.

## Motivation

A standard interface allows wallet/broker/auction applications to work with any NTT on Ethereum. We provide for simple nntSetup smart contracts as well as contracts that track an *arbitrarily large* number of NTTs. Additional applications are discussed below.

This standard is inspired by the ERC-721 token standard.


## Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/PandiaJason/Non-Transferable-Non-Fungible-Tokens/blob/main/ERC721URIStorage.sol";
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



## References

**Standards**
1. [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) Token Standard.
1. [ERC-165](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md) Standard Interface Detection.
1. [ERC-721](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md) Non-Fungible Token Standard.
