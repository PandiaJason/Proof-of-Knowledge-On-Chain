// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IPIS1.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Immutable is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // address[]  public nntHolder;
    address public immutable nntHolder;


    constructor(address  _nntHolder) ERC721("non-transferable token", "NTT") {
        nntHolder = _nntHolder;
    }

    function addNtt(string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(nntHolder, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

}
