const hre = require("hardhat");

async function main() {
	const [deployer] = await ethers.getSigners();
	console.log("Deploying contracts with the account:", deployer.address);

	// Desplegar el contrato MinimalForwarder
	const Forwarder = await ethers.getContractFactory("MinimalForwarder");
	const forwarder = await Forwarder.deploy();

	console.log("MinimalForwarder deployed to:", forwarder.target);

	// Desplegar el contrato TokenMinter usando la dirección del forwarder
	const TokenMinter = await ethers.getContractFactory("TokenMinter");
	const tokenMinter = await TokenMinter.deploy(forwarder.target); // Pasar la dirección del forwarder

	console.log("TokenMinter deployed to:", tokenMinter.target);

	const forwarderAddress = await tokenMinter.getTrustedForwarder();
	console.log("Trusted Forwarder set in TokenMinter:", forwarderAddress);

	if (forwarderAddress === forwarder.target) {
		console.log("Forwarder correctly configured.");
	} else {
		console.log("Forwarder NOT correctly configured.");
	}
	console.log("Both contracts deployed successfully!");
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
