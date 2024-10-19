const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // El trusted forwarder del relayer
  const trustedForwarder = process.env.RELAYER; // Cambia esta dirección por la de tu relayer
  console.log("Relayer address:", trustedForwarder);

  // Desplegar el contrato de minteo
  const TokenMinter = await hre.ethers.getContractFactory("TokenMinter");
  const tokenMinter = await TokenMinter.deploy(trustedForwarder);

  

  console.log("TokenMinter deployed to:", tokenMinter.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
