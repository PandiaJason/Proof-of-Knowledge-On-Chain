# Non-Transferable-Non-Fungible-Tokens
"Implementation of Non-Transferable-Non Fungible Tokens using Non-Fungible Token"

## Simple Summary

A standard interface for non-fungible tokens, also known as deeds.

## Abstract

The following standard allows for the implementation of a standard API for NTNFTs within smart contracts. This standard provides basic functionality to track and mint  NTNFTs aka NTTs.

We considered use cases of NTTs being issued by authentic authorities("issuers/operators") to individuals("users". NTTs can represent ownership over authentic digital assets. We considered a diverse universe of assets, and we know you will dream up many more:

- Non Fungible property — unique identities, credientials
- No Value — authentic tokens with no monetry value
- "Trust Minimization" Economy — Open, Transperent and Secured on chains.

In general, all human credentials are distinct and no two credential are alike. NTTs are *distinguishable* and you must track the ownership of each one separately.

## Motivation

A standard interface allows wallet/broker/auction applications to work with any NTT on Ethereum. We provide for simple nntSetup smart contracts as well as contracts that track an *arbitrarily large* number of NTTs. Additional applications are discussed below.

This standard is inspired by the ERC-721 token standard.
