# Understanding ConfidentialERC20

The **ConfidentialERC20** contract is a privacy-preserving implementation of the ERC20 token standard, leveraging **Fully Homomorphic Encryption (FHE)**. It combines the familiar functionality of ERC20 tokens with powerful encryption features to protect user privacy.

## Key features

### Encrypted balances

ConfidentialERC20 revolutionizes the way balances are stored by encrypting them using FHE.

- **Enhanced Privacy**: Balances are stored as encrypted values (`euint64`), ensuring no one can view account balances by inspecting the blockchain.
- **Exclusive Access**: Only the account owner can decrypt and view their own balance.
- **Encrypted Transactions**: Transaction amounts are also encrypted, maintaining confidentiality.

### Standard ERC20 Functions with Encryption

ConfidentialERC20 supports all the standard ERC20 functions, adapted for encrypted values. For example:

- `transfer`: Securely transfers encrypted tokens.
- `approve`: Approves encrypted amounts for spending.
- `transferFrom`: Transfers tokens on behalf of another address.
- `balanceOf`: Returns the encrypted balance of an account.
- `totalSupply`: Returns the encrypted total token supply.

To dive deeper into the workings of ConfidentialERC20, check out the [Zama blog post](https://www.zama.ai/post/confidential-erc-20-tokens-using-homomorphic-encryption).

## What is `ConfidentialERC20Mintable`?

The **`ConfidentialERC20Mintable`** contract, part of the **`fhevm-contracts`** library, extends the ConfidentialERC20 by adding **minting capabilities**.

### **Key Features**

- **All ConfidentialERC20 functions**: Since the `ConfidentialERC20Mintable` is extending the `ConfidentialERC20` contract, it has all the functionalities that the `ConfidentialERC20` contract has.
- **Minting**: The contract owner can securely create new tokens and distribute them.

## What are `fhevm-contracts`?

The `fhevm-contracts` library is a collection of **privacy-preserving smart contracts** built specifically for the **fhEVM** (Fully Homomorphic Encryption Virtual Machine). It provides:

- **Ready-to-use confidential contracts**: Pre-built implementations of common token standards with FHE capabilities
- **Base contracts**: Foundational building blocks for creating custom confidential smart contracts
- **Extensions**: Additional features and utilities that can be added to base contracts
- **Testing utilities**: Tools to help test FHE-enabled smart contracts

The library serves as both a reference implementation and a toolkit for developers building privacy-focused applications on the fhEVM. It demonstrates best practices for implementing confidential operations while maintaining compatibility with existing Ethereum standards.

To learn more about the `fhevm-contracts` and how to use them refer to the [fhevm-contracts page-](../../smart_contracts/contracts.md)
