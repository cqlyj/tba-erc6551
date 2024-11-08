// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyNft is ERC721, Ownable {
    uint256 private s_tokenId;

    constructor() ERC721("MyNft", "MNFT") Ownable(msg.sender) {
        s_tokenId = 0;
    }

    function mint(address to) external onlyOwner {
        _safeMint(to, s_tokenId);
        s_tokenId++;
    }

    function tokenId() external view returns (uint256) {
        return s_tokenId;
    }
}
