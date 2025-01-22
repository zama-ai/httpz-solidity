# Understanding ConfidentialERC20

The **ConfidentialERC20** contract is a privacy-preserving implementation of the ERC20 token standard, leveraging **Fully Homomorphic Encryption (FHE)**. It combines the familiar functionality of ERC20 tokens with powerful encryption features to protect user privacy.

---

## Key Features

### 1. **Encrypted Balances**

ConfidentialERC20 revolutionizes the way balances are stored by encrypting them using FHE.

- **Enhanced Privacy**: Balances are stored as encrypted values (`euint64`), ensuring no one can view account balances by inspecting the blockchain.
- **Exclusive Access**: Only the account owner can decrypt and view their own balance.
- **Encrypted Transactions**: Transaction amounts are also encrypted, maintaining confidentiality.

---

### 2. **Standard ERC20 Functions with Encryption**

ConfidentialERC20 supports all the standard ERC20 functions, adapted for encrypted values. For example:

- `transfer`: Securely transfers encrypted tokens.
- `approve`: Approves encrypted amounts for spending.
- `transferFrom`: Transfers tokens on behalf of another address.
- `balanceOf`: Returns the encrypted balance of an account.
- `totalSupply`: Returns the encrypted total token supply.

---

## What is `ConfidentialERC20Mintable`?

The **`ConfidentialERC20Mintable`** contract, part of the **`fhevm-contracts`** library, extends the ConfidentialERC20 by adding **minting capabilities**.

### **Key Features**

- **Confidential Balances**: All balances are encrypted, safeguarding user privacy.
- **Minting**: The contract owner can securely create new tokens and distribute them.

## What are `fhevm-contracts`?

The `fhevm-contracts` library is a collection of **privacy-preserving smart contracts** built specifically for the **fhEVM** (Fully Homomorphic Encryption Virtual Machine). It provides:

- **Ready-to-use confidential contracts**: Pre-built implementations of common token standards with FHE capabilities
- **Base contracts**: Foundational building blocks for creating custom confidential smart contracts
- **Extensions**: Additional features and utilities that can be added to base contracts
- **Testing utilities**: Tools to help test FHE-enabled smart contracts

The library serves as both a reference implementation and a toolkit for developers building privacy-focused applications on the fhEVM. It demonstrates best practices for implementing confidential operations while maintaining compatibility with existing Ethereum standards.

### Key Components

- **Token Standards**: Confidential versions of popular token standards (ERC20, ERC721, etc.)
- **Access Control**: FHE-compatible permission and role management systems
- **Security Features**: Built-in safeguards and checks for encrypted operations
- **Utility Functions**: Helper methods for common FHE operations

## Installing `fhevm-contracts`

While Remix automatically imports dependencies, you can manually install the `fhevm-contracts` library for local development:

```bash
# Using npm
npm install fhevm-contracts

# Using Yarn
yarn add fhevm-contracts

# Using pnpm
pnpm add fhevm-contracts
```

---

## Additional Examples in `fhevm-contracts`

Here are more examples of contracts available in the **fhevm-contracts** library:

- [**ConfidentialERC20**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialERC20.sol): Standard encrypted ERC20 implementation.
- [**ConfidentialERC20Wrapped**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialERC20Wrapped.sol): Wrapped ERC20 tokens with encryption.
- [**ConfidentialWETH**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/ConfidentialWETH.sol): Confidential version of wrapped Ether.
- [**ConfidentialERC20Mintable**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20Mintable.sol): ERC20 with encryption and minting capabilities.
- [**ConfidentialERC20WithErrors**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20WithErrors.sol): ERC20 with encrypted balances and integrated error handling.
- [**ConfidentialERC20WithErrorsMintable**](https://github.com/zama-ai/fhevm-contracts/blob/main/contracts/token/ERC20/extensions/ConfidentialERC20WithErrorsMintable.sol): Combines minting and error handling in an encrypted ERC20 token.

---

### Learn more

For this tutorial, we focus on the **`ConfidentialERC20Mintable`** contract, as it provides both the essential functionalities of ERC20 and secure minting. To dive deeper into the workings of ConfidentialERC20, check out the [Zama blog post](https://www.zama.ai/post/confidential-erc-20-tokens-using-homomorphic-encryption).

Explore more advanced features and concepts in the next section! 🚀
