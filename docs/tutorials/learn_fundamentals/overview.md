# Tutorial: Learn fhEVM fundamentals using Hardhat

Throughout this tutorial you will build upon a basic Counter example. These examples are designed to guide you step-by-step through the development of confidential smart contracts, introducing new concepts progressively to deepen your understanding of **fhEVM**.

The primary example, `ConfidentialCounter.sol`, is enhanced in stages to demonstrate a variety of features and best practices for encrypted computations.

- [Counter1.sol](./configure.md) - Introduction to basic encrypted state variables and simple operations.
- [Counter2.sol](./encryption.md) - Incorporating encrypted inputs into the contract for enhanced functionality.
- [Counter3.sol](./reencryption.md) - Introduction to decryption and how contracts can interact with the Gateway.
- [Counter4.sol](./decryption.md) - Introduction to re-encryption, enabling secure sharing of encrypted data.

Each iteration of the counter will build upon previous concepts while introducing new functionality, helping you understand how to develop robust confidential smart contracts.

## Step-by-step workflow

### 1. (Optional) Learn the overall architecture

Before diving into development, we recommend understanding the overall architecture of fhEVM:

- [**Architecture overview**](../../smart_contracts/architecture_overview.md): Learn how fhEVM enables confidential smart contracts
- [**Encryption & computation**](../../smart_contracts/d_re_ecrypt_compute.md): Understand how data is encrypted, decrypted and computed
- [**Access control**](../../smart_contracts/acl): Learn about managing access to encrypted data

This knowledge will help you make better design decisions when building your confidential smart contracts.

### 2. Use the Hardhat template

Begin with our custom [`fhevm-hardhat-template` repository](https://github.com/zama-ai/fhevm-hardhat-template).

- **Why Hardhat?**: It is a powerful Solidity development environment, offering tools for writing, testing, and deploying contracts to the `fhEVM` using TypeScript.
- **Benefit**: The template provides a pre-configured setup tailored to confidential smart contracts, saving development time and ensuring compatibility.

### 3. Configure the contract

Choose and inherit the correct configuration based on the environment:

- **Mock network**: For local testing and development.
- **Testnets (e.g., Sepolia)**: For deploying to public test networks.
- **Mainnet**: When deploying to production.

Ensure configuration contracts (e.g., `SepoliaZamaFHEVMConfig`, `SepoliaZamaFHEVMConfig`) are inherited correctly to initialize encryption parameters, cryptographic keys, and Gateway addresses. See [configuration](../../smart_contracts/configure.md) for more details.

### 4. Begin with unencrypted logic

Develop your contract as you would for a traditional EVM chain:

- Use cleartext variables and basic logic to simplify debugging and reasoning about the contract’s behavior.
- Focus on implementing core functionality without adding encryption initially.

For a step-by-step guide on developing your first confidential smart contract, see our [First smart contract](../fundamentals/first_smart_contract.md). This guide covers:

- Creating a basic encrypted counter contract
- Understanding the configuration process
- Working with encrypted state variables

Key resources for working with encrypted types:

- [Supported encrypted types](../../smart_contracts/types.md) - Learn about euint8, euint16, euint32, euint64, ebool and eaddress
- [Encrypted operations](../../smart_contracts/operations.md) - Understand arithmetic, comparison, and logical operations on encrypted data

### 5. Add encryption

Once the logic is stable, integrate the `TFHE` Solidity library to enable encryption:

- **Convert sensitive variables**: Replace plaintext types like `uintX` with encrypted types such as `euintX`.
- **Enable confidentiality**: Encrypted variables and operations ensure sensitive data remains private while still being processed.

Learn how to implement core encryption operations:

- [Encrypting inputs](../../smart_contracts/inputs.md) - Create and validate encrypted inputs
- [Decrypting values](../../smart_contracts/decryption/decrypt.md) - Securely decrypt data for authorized users
- [Reencryption](../../smart_contracts/decryption/reencryption.md) - Share encrypted data between parties

### 6. Follow best practices

Throughout the documentation, you'll find sections marked with 🔧 that highlight important best practices. These include:

- **Optimized data types:** Use appropriately sized encrypted types (`euint8`, `euint16`, etc.) to minimize gas costs.
- **Scalar operands:** Whenever possible, use scalar operands in operations to reduce computation and gas usage.
- **Overflow handling:** Manage arithmetic overflows in encrypted operations using conditional logic (`TFHE.select`).
- **Secure access control:** Use `TFHE.allow` and `TFHE.isSenderAllowed` to implement robust ACL (Access Control List) mechanisms for encrypted values.
- **Reencryption patterns:** Follow the recommended approaches for reencryption to share or repurpose encrypted data securely.

### 7. Leverage example templates

Use the [`fhevm-contracts repository`](https://github.com/zama-ai/fhevm-contracts) for pre-built examples:

- **Why templates?**: They demonstrate common patterns and best practices for encrypted operations, such as governance, token standards, and utility contracts.
- **How to use**: Extend or customize these templates to suit your application’s needs.

For more details, explore the [fhevm-contracts documentation](../../smart_contracts/contracts.md).
