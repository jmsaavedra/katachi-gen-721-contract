const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  // Optional: set MINTER_ADDRESS in .env to grant minter role on deploy
  const minterAddress = process.env.MINTER_ADDRESS;

  console.log("Deploying KatachiGenV5 with account:", deployer.address);
  console.log("Account balance:", (await hre.ethers.provider.getBalance(deployer.address)).toString());
  if (minterAddress) {
    console.log("Will grant MINTER_ROLE to:", minterAddress);
  }

  const KatachiGenV5 = await hre.ethers.getContractFactory("KatachiGenV5");

  // Deploy with deployer as initial owner
  const contract = await KatachiGenV5.deploy(deployer.address);
  await contract.waitForDeployment();

  const contractAddress = await contract.getAddress();
  console.log("KatachiGenV5 deployed to:", contractAddress);

  // Grant minter role if MINTER_ADDRESS is set
  if (minterAddress) {
    console.log("Granting MINTER_ROLE to:", minterAddress);
    const tx = await contract.grantMinterRole(minterAddress);
    await tx.wait();
    console.log("MINTER_ROLE granted!");
  }

  // Wait for a few block confirmations before verifying
  console.log("Waiting for block confirmations...");
  await contract.deploymentTransaction().wait(5);

  // Verify on ShapeScan
  console.log("Verifying contract on ShapeScan...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: [deployer.address],
    });
    console.log("Contract verified!");
  } catch (error) {
    if (error.message.includes("Already Verified")) {
      console.log("Contract already verified");
    } else {
      console.error("Verification failed:", error.message);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
