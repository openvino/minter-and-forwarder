# OpenVino Minter and Forwarder

## Overview

The OpenVino Minter and Forwarder is a decentralized application (DApp) designed for managing the minting and forwarding of OpenVino wine-backed tokens. This software is used to mint tokens and transfer them to other wallets using smart contracts. The minter handles the generation of new tokens, while the forwarder manages the transfer of tokens between wallets.

This software was developed as part of migration of OpenVino.Exchange from Ethereum mainnet to Base. This applicaitonis designed to be used by the OpenVino project for deploying new tokens for wineries, and forms part of a broader reaching token provisioning service, as described here:

https://openvino.atlassian.net/wiki/spaces/OPENVINO/pages/187465735/Provisioning+Tool+Requirements

This project is part of the OpenVinoDAO ecosystem that enables secure, trustless token operations through Ethereum smart contracts.

## Key Features

- **Token Minting**: Generates new OpenVino wine tokens directly from the smart contract when certain conditions are met.
- **Token Forwarding**: Automates the process of transferring tokens between wallets, improving ease of use for decentralized applications.
- **Smart Contract Integration**: Uses smart contracts for secure, trustless transactions.
- **Gas Efficiency**: Optimized for gas efficiency to minimize the cost of minting and forwarding tokens.
- **Customization**: The smart contracts can be customized to meet specific minting and forwarding rules as per user needs.
  
## Installation

To install the OpenVino Minter and Forwarder on your local machine, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/openvino/minter-and-forwarder.git
   cd minter-and-forwarder
   ```

2. **Install Dependencies**:
   The project uses `npm` or `yarn` to manage dependencies. Run the following command:
   ```bash
   npm install
   # or
   yarn install
   ```

3. **Compile Smart Contracts**:
   Ensure you have `truffle` or `hardhat` installed to compile the smart contracts:
   ```bash
   npx hardhat compile
   ```

4. **Deploy Smart Contracts**:
   To deploy the contracts to your preferred Ethereum network:
   ```bash
   npx hardhat run scripts/deploy.js --network <network>
   ```

## Usage

### Minting Tokens

To mint new OpenVino tokens, the `Minter` contract exposes a function `mint(address recipient, uint256 amount)` that can be called to generate new tokens for the specified recipient.

Example:
```javascript
const Minter = await ethers.getContractFactory("Minter");
await Minter.mint("0xRecipientAddress", 1000);
```

### Forwarding Tokens

The `Forwarder` contract is responsible for transferring tokens from one wallet to another. Use the `forward(address recipient, uint256 amount)` function to send tokens.

Example:
```javascript
const Forwarder = await ethers.getContractFactory("Forwarder");
await Forwarder.forward("0xRecipientAddress", 1000);
```

## Smart Contracts

- **Minter.sol**: Handles the creation of new tokens. It ensures that tokens are only minted under specific conditions defined in the contract.
- **Forwarder.sol**: Handles the automatic transfer of tokens between addresses. It acts as a utility contract to make token transfers easier for decentralized applications.

## Testing

To run tests for the Minter and Forwarder contracts, execute the following command:
```bash
npx hardhat test
```

This will run all unit tests defined in the `test/` directory, ensuring the integrity of the minting and forwarding logic.

## Deployment

To deploy the smart contracts to a live network (e.g., Ethereum Mainnet or a testnet), use the deployment script and specify the network:
```bash
npx hardhat run scripts/deploy.js --network mainnet
```

Ensure your environment variables (such as private keys and network endpoints) are properly set up in a `.env` file.

## Contribution

We welcome contributions! If you'd like to contribute to the OpenVino Minter and Forwarder project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes.
4. Submit a pull request.

Please ensure that your contributions adhere to the project's coding standards and are accompanied by relevant test cases.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

## Contact

For any questions or support related to this project, please contact the OpenVinoDAO team at [info@openvino.org](mailto:info@openvino.org).

---
