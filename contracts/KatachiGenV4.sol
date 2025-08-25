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
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract KatachiGenV4 is ERC721Enumerable, ERC721Burnable, Ownable, ReentrancyGuard, AccessControl {
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    uint256 public mintPrice = 0.0025 ether;
    uint256 public maxSupply = 10000;
    bool public publicSaleActive = false;
    
    mapping(uint256 => string) private _tokenURIs;
    
    constructor(address initialOwner) 
        ERC721("KatachiGen", "KGEN") 
        Ownable(initialOwner) {
        
        // Grant admin role to owner
        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
        // Grant minter role to owner initially
        _grantRole(MINTER_ROLE, initialOwner);
    }

    // Single transaction: pay + mint + forward payment to owner
    function mint(uint256 quantity) external payable nonReentrant {
        require(publicSaleActive, "Public sale not active");
        require(quantity > 0 && quantity <= 10, "Invalid quantity");
        require(totalSupply() + quantity <= maxSupply, "Exceeds max supply");
        
        uint256 totalCost = mintPrice * quantity;
        require(msg.value >= totalCost, "Insufficient payment");
        
        // Immediately forward payment to owner wallet
        (bool success,) = payable(owner()).call{value: totalCost}("");
        require(success, "Payment transfer failed");
        
        // Mint tokens to buyer
        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = totalSupply() + 1;
            _safeMint(msg.sender, tokenId);
        }
        
        // Refund excess payment if any
        if (msg.value > totalCost) {
            (bool refundSuccess,) = payable(msg.sender).call{value: msg.value - totalCost}("");
            require(refundSuccess, "Refund failed");
        }
    }

    // Owner functions
    function setMintPrice(uint256 _price) external onlyOwner {
        mintPrice = _price;
    }
    
    function togglePublicSale() external onlyOwner {
        publicSaleActive = !publicSaleActive;
    }

    // Free minting for owner (airdrops)
    function ownerMint(address to, uint256 quantity) external onlyOwner {
        require(totalSupply() + quantity <= maxSupply, "Exceeds max supply");
        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = totalSupply() + 1;
            _safeMint(to, tokenId);
        }
    }

    // Metadata functions
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

    function setTokenURI(uint256 tokenId, string memory uri) external onlyRole(MINTER_ROLE) {
        _requireOwned(tokenId);
        _setTokenURI(tokenId, uri);
    }

    // Role management functions
    /**
     * @dev Grant minter role to an address (only owner)
     */
    function grantMinterRole(address account) external onlyOwner {
        grantRole(MINTER_ROLE, account);
    }

    /**
     * @dev Revoke minter role from an address (only owner) 
     */
    function revokeMinterRole(address account) external onlyOwner {
        revokeRole(MINTER_ROLE, account);
    }

    /**
     * @dev Check if address has minter role
     */
    function isMinter(address account) external view returns (bool) {
        return hasRole(MINTER_ROLE, account);
    }

    // Required overrides for ERC721Enumerable
    function _update(address to, uint256 tokenId, address auth) 
        internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) 
        internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId) 
        public view override(ERC721, ERC721Enumerable, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}