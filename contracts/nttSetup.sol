// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NTT is ERC721URIStorage {
  using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // address[]  public nttHolder;
    address public immutable nttHolder;

    constructor(address  _nttHolder) ERC721("Non-Transferable-Token", "NTT") {
    // constructor(address  _nttHolder, string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        nttHolder = _nttHolder;
    }

    function addNtt(string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(nttHolder, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

}
