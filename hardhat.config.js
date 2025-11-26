require("@nomicfoundation/hardhat-toolbox");

// Load environment variables from .env file if it exists
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    // ShapeL2 Mainnet
    shape: {
      url: process.env.SHAPE_RPC_URL || "https://mainnet.shape.network",
      chainId: 360,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    // ShapeL2 Sepolia Testnet
    shapeSepolia: {
      url: process.env.SHAPE_SEPOLIA_RPC_URL || "https://sepolia.shape.network",
      chainId: 11011,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    // Blockscout doesn't require a real API key - any non-empty string works
    apiKey: {
      shape: "no-api-key-needed",
      shapeSepolia: "no-api-key-needed",
    },
    customChains: [
      {
        network: "shape",
        chainId: 360,
        urls: {
          apiURL: "https://shapescan.xyz/api",
          browserURL: "https://shapescan.xyz",
        },
      },
      {
        network: "shapeSepolia",
        chainId: 11011,
        urls: {
          apiURL: "https://sepolia.shapescan.xyz/api",
          browserURL: "https://sepolia.shapescan.xyz",
        },
      },
    ],
  },
};
