# 1Password secret references - used with `op run`
# Update the references below to match your 1Password vault/item/field paths

# Deployer Wallet (production)
# PRIVATE_KEY="op://Private/Katachi Gen Wallets/QUIETLOOPS/pkey"

# KG Minter (dev)
PRIVATE_KEY="op://Private/Katachi Gen Wallets/KGen Minter/pkey"

# RPC URLs
SHAPE_RPC_URL=https://shape-mainnet.g.alchemy.com/public
SHAPE_SEPOLIA_RPC_URL=https://shape-sepolia.g.alchemy.com/public

# Optional: Grant MINTER_ROLE to this address on deploy
MINTER_ADDRESS="op://Private/Katachi Gen Wallets/KGen Minter/address"
