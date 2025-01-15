---
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: false
---

# Deploying ConfidentialERC20

This guide walks you through creating your first smart contract using the **Fully Homomorphic Encryption Virtual Machine (fhEVM)**. We'll create a confidential token powered by **Zama's FHE library**.

For this example, we'll create a new file for our smart contract, name it `MyConfidentialERC20.sol`, and gradually build its functionality.

## Basic structure

Every smart contract written for fhEVM has a consistent foundational structure. Begin by setting up the base configuration and importing required libraries:

```solidity
// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";
import "fhevm/config/ZamaFHEVMConfig.sol";

contract MyConfidentialERC20 is SepoliaZamaFHEVMConfig {}
```

### Explanation of the Structure

#### 1. **`TFHE.sol`**

This library provides access to Zama's **Fully Homomorphic Encryption** (FHE) tools. It allows developers to work with encrypted types (e.g., `euint64`, `ebool`) and perform secure, encrypted operations like addition, comparison, and logical conditions.

#### 2. **`SepoliaZamaFHEVMConfig`**

This configuration file connects your smart contract to the Sepolia testnet’s **fhEVM coprocessor**, enabling real encrypted computations and decryption operations. It simplifies deployment by pre-setting necessary contract addresses for fhEVM components.

### Compiling Your Contract

Remix should automatically import all required libraries. To verify:

1. Go to the **Solidity Compiler** tab in Remix.
2. Select your contract file and click **Compile**.

If it compiles successfully, you're ready to proceed!

## Adding Functionality

Next, let’s enhance the contract to implement an encrypted ERC20-like token with minting capabilities:

```solidity
// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";
import "fhevm/config/ZamaFHEVMConfig.sol";
import "fhevm-contracts/contracts/token/ERC20/extensions/ConfidentialERC20Mintable.sol";

/// @notice This contract implements an encrypted ERC20-like token with confidential balances using Zama's FHE library.
/// @dev It supports typical ERC20 functionality such as transferring tokens, minting, and setting allowances,
/// @dev but uses encrypted data types.
contract MyConfidentialERC20 is SepoliaZamaFHEVMConfig, ConfidentialERC20Mintable {
  /// @notice Constructor to initialize the token's name and symbol, and set up the owner
  /// @param name_ The name of the token
  /// @param symbol_ The symbol of the token
  constructor(string memory name_, string memory symbol_) ConfidentialERC20Mintable(name_, symbol_, msg.sender) {}
}
```

### What is `ConfidentialERC20Mintable`?

The `ConfidentialERC20Mintable` contract is part of the **`fhevm-contracts`** library. It builds upon the ERC20 standard by adding encrypted balances and minting capabilities.

#### Key Features:

- **Confidential Balances**: User balances are encrypted, preserving privacy on-chain.
- **Minting**: The contract owner can mint new tokens securely.

#### Example Functions:

- **Mint**: `mint(address to, uint64 amount)` allows the owner to create new tokens.
- **Transfer**: Securely transfers tokens between addresses while maintaining confidentiality.

#### Installing `fhevm-contracts`

Although Remix automatically imports dependencies, you can install the `fhevm-contracts` library manually for local development:

```bash
# Using npm
npm install fhevm-contracts

# Using Yarn
yarn add fhevm-contracts

# Using pnpm
pnpm add fhevm-contracts
```

Although Remix does this automatically.

Some of the examples related to ConfidentialERC20 are:

- [ConfidentialERC20](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialERC20.sol): Standard confidential ERC20 with encryption.
- [ConfidentialERC20Wrapped](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialERC20Wrapped.sol): Wrapped ERC20 with encryption.
- [ConfidentialWETH](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialWETH.sol): Confidential wrapped WETH with encryption.
- [ConfidentialERC20Mintable](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20Mintable.sol): ERC20 with minting capabilities.
- [ConfidentialERC20WithErrors](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20WithErrors.sol): ERC20 with integrated error handling.
- [ConfidentialERC20WithErrorsMintable](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20WithErrorsMintable.sol): ERC20 with both minting and error handling.

For this example we took `ConfidentialERC20Mintable`, which allows you to use all of the main functionalities of ERC20 + mint the tokens. Let's learn more about ConfidentialERC20 in the next page.

#### Compile and deploy the code

-> go to the Solidity compiler click compile
-> Go to Deploy and run transactions, choose injected provider - Metamask
-> Right of the deploy button you will arrow, expand it and populate the NAME* and SYMBOL*
-> Click transact
-> Your wallet should pop up make sure you have sufficient Sepolia to deploy and interact with your smart contract
