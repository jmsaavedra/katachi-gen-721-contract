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

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract KatachiGen is Initializable, ERC721Upgradeable, ERC721BurnableUpgradeable, OwnableUpgradeable {
    
    // Efficient metadata handling
    mapping(uint256 => string) private _tokenURIs;
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __ERC721_init("KatachiGen", "KGEN");
        __ERC721Burnable_init();
        __Ownable_init(initialOwner);
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function safeMintWithURI(address to, uint256 tokenId, string memory uri) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        
        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }

    function setTokenURI(uint256 tokenId, string memory uri) public onlyOwner {
        _requireOwned(tokenId);
        _setTokenURI(tokenId, uri);
    }
}
