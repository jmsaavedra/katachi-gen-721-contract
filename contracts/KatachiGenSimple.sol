// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/*

    ╦╔═╔═╗╔╦╗╔═╗╔═╗╦ ╦╦  ╔═╗╔═╗╔╗╔
    ╠╩╗╠═╣ ║ ╠═╣║  ╠═╣║  ║ ╦║╣ ║║║
    ╩ ╩╩ ╩ ╩ ╩ ╩╚═╝╩ ╩╩  ╚═╝╚═╝╝╚╝

    https://katachi-gen.com

    by quietloops (x.com/quietloops)
    and sembo (x.com/1000b)
*/

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KatachiGenSimple is ERC721Enumerable, ERC721Burnable, Ownable {
    
    // Efficient metadata handling
    mapping(uint256 => string) private _tokenURIs;
    
    constructor(address initialOwner) ERC721("KatachiGen", "KGEN") Ownable(initialOwner) {}

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function safeMintWithURI(address to, uint256 tokenId, string memory uri) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721Enumerable) returns (string memory) {
        _requireOwned(tokenId);
        
        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return ERC721.tokenURI(tokenId);
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }

    function setTokenURI(uint256 tokenId, string memory uri) public onlyOwner {
        _requireOwned(tokenId);
        _setTokenURI(tokenId, uri);
    }

    // Required override for ERC721Enumerable
    function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    // Required override for ERC721Enumerable  
    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    // Required override for ERC721Enumerable
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}