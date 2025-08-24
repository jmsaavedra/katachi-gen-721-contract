# Katachi Gen ERC721 Smart Contract

This repository contains the ERC721 smart contract for the Katachi Gen project - an NFT collection that generates unique digital art pieces.

## Overview

The Katachi Gen ERC721 contract implements the standard NFT functionality with additional features for the Katachi Gen project, enabling the minting, trading, and management of unique digital collectibles.

## Features

- Standard ERC721 implementation
- Efficient metadata handling with per-token URI support
- Owner-only minting functionality
- Burnable tokens
- OpenSea compatibility
- Gas-optimized for Shape Network's gasback program

## Deployed Contract

**Shape Mainnet** ✅ **DEPLOYED & VERIFIED**
- Contract Address: `0x9fba90186403d1c5e3e1971536862cf4ebb0f766`
- Explorer: [View on ShapeScan](https://shapescan.xyz/address/0x9fba90186403d1c5e3e1971536862cf4ebb0f766?tab=contract)
- Token Name: "KatachiGen"
- Symbol: "KGEN"
- Owner: `0x56bdE1E5efC80B1E2B958f2D311f4176945Ae77f`
- Status: **LIVE & VERIFIED** - Ready for minting!

**Shape Testnet (Sepolia)**
- Contract Address: `0x9FdB107c9AAE301F021e1F34BEB8Ca6F2324de85`
- Explorer: [View on ShapeScan](https://sepolia.shapescan.xyz/address/0x9FdB107c9AAE301F021e1F34BEB8Ca6F2324de85)
- Token Name: "KatachiGen"
- Symbol: "KGEN"
- Owner: `0x56bdE1E5efC80B1E2B958f2D311f4176945Ae77f`

## Minting Instructions

### Using RemixIDE

1. **Connect to Shape Testnet**
   - Add Shape Testnet to MetaMask
   - Network: Shape Testnet Sepolia
   - Get test ETH from Shape faucet

2. **Access Contract in RemixIDE**
   - Open [Remix IDE](https://remix.ethereum.org/)
   - Go to "Deploy & Run Transactions" tab
   - Select "Injected Provider - MetaMask"
   - Under "At Address", paste: `0x9FdB107c9AAE301F021e1F34BEB8Ca6F2324de85`
   - Click "At Address" button

3. **Mint NFTs (Owner Only)**
   
   **Basic Mint:**
   ```
   safeMint(recipientAddress, tokenId)
   ```
   Example: `safeMint("0x56bdE1E5efC80B1E2B958f2D311f4176945Ae77f", 1)`
   
   **Mint with Metadata:**
   ```
   safeMintWithURI(recipientAddress, tokenId, "metadataURI")
   ```
   Example: `safeMintWithURI("0x56bdE1E5efC80B1E2B958f2D311f4176945Ae77f", 2, "ipfs://QmYourMetadataHash")`

4. **Verify Minting**
   - `ownerOf(tokenId)` - Check token owner
   - `tokenURI(tokenId)` - Check metadata
   - `balanceOf(address)` - Check address balance

### Available Functions

**View Functions:**
- `name()` - Returns "KatachiGen"
- `symbol()` - Returns "KGEN"
- `owner()` - Returns contract owner
- `ownerOf(tokenId)` - Returns token owner
- `tokenURI(tokenId)` - Returns metadata URI
- `balanceOf(address)` - Returns token count

**Owner Functions:**
- `safeMint(to, tokenId)` - Mint token to address
- `safeMintWithURI(to, tokenId, uri)` - Mint with metadata
- `setTokenURI(tokenId, uri)` - Update token metadata
- `burn(tokenId)` - Burn owned token (token owner can call)

## Development

### Prerequisites

- Access to [Remix IDE](https://remix.ethereum.org/)
- MetaMask with Shape Testnet configured
- Test ETH from Shape faucet

### Local Development

1. Clone this repository
2. Open contracts in Remix IDE
3. Compile using Solidity compiler 0.8.20+
4. Deploy `KatachiGenSimple.sol` for standard deployment

## Shape Network Benefits

- **Gasback Program**: Contract owner receives 80% of sequencer fees back
- **Lower Gas Costs**: L2 scaling benefits
- **EVM Compatibility**: Works with all Ethereum tooling
- **Creator-Focused**: Designed for NFT and creative projects

## License

This project is licensed under the MIT License.

## Related Projects

- Main Katachi Gen project: [https://github.com/jmsaavedra/katachi-gen](https://github.com/jmsaavedra/katachi-gen)