# Tutorial: Learn fhEVM fundamentals using Hardhat

Throughout this tutorial you will build upon a basic Counter example. These examples are designed to guide you step-by-step through the development of confidential smart contracts, introducing new concepts progressively to deepen your understanding of **fhEVM**.

The primary example, `ConfidentialCounter.sol`, is enhanced in stages to demonstrate a variety of features and best practices for encrypted computations.

- [1. Setting up Hardhat](tutorials/learn_fundamentals/hardhat.md)
- [2. Configure the contract](tutorials/learn_fundamentals/configure.md)
- [3. Add encrypted inputs](tutorials/learn_fundamentals/encryption.md)
- [4. Decrypt only for the user](tutorials/learn_fundamentals/reencryption.md)
- [5. Decrypt for everyone](tutorials/learn_fundamentals/decryption.md)

Each iteration of the counter will build upon previous concepts while introducing new functionality, helping you understand how to develop robust confidential smart contracts.

## Step-by-step workflow

### 1. (Optional) Learn the overall architecture

Before diving into development, we recommend understanding the overall architecture of fhEVM:

- [**Architecture overview**](../../smart_contracts/architecture_overview.md): Learn how fhEVM enables confidential smart contracts
- [**Encryption & computation**](../../smart_contracts/d_re_ecrypt_compute.md): Understand how data is encrypted, decrypted and computed
- [**Access control**](../../smart_contracts/acl): Learn about managing access to encrypted data

This knowledge will help you make better design decisions when building your confidential smart contracts.

### 2. Choose your development environment

- [`fhevm-hardhat-template` repository](https://github.com/zama-ai/fhevm-hardhat-template)
- [remix](../../getting_started/quick_start/remix.md)

### 3. Configure the contract

Choose and inherit the correct configuration based on the environment:

- **Mock network**: For local testing and development - does not need it's own configuration
- **Testnets (e.g., Sepolia)**: For deploying to public test networks (e.g., `SepoliaZamaFHEVMConfig`, `SepoliaZamaFHEVMConfig`)
- **Mainnet**: When deploying to production (coming soon)

### 4. Add encryption

Learn how to implement core encryption operations:

- [Encrypting inputs](../../smart_contracts/inputs.md) - Create and validate encrypted inputs
- [Decrypting values](../../smart_contracts/decryption/decrypt.md) - Securely decrypt data for authorized users
- [Reencryption](../../smart_contracts/decryption/reencryption.md) - Share encrypted data between parties

### 5. Follow best practices

Throughout the documentation, you'll find sections titled **best practices**. Quick overview:

- **Optimized data types:** Use appropriately sized encrypted types (`euint8`, `euint16`, etc.) to minimize gas costs.
- **Scalar operands:** Whenever possible, use scalar operands in operations to reduce computation and gas usage.
- **Overflow handling:** Manage arithmetic overflows in encrypted operations using conditional logic (`TFHE.select`).
- **Secure access control:** Use `TFHE.allow` and `TFHE.isSenderAllowed` to implement robust ACL (Access Control List) mechanisms for encrypted values.
- **Reencryption patterns:** Follow the recommended approaches for reencryption to share or repurpose encrypted data securely.

### 7. Leverage extendable contract templates

Use the [`fhevm-contracts repository`](https://github.com/zama-ai/fhevm-contracts) for pre-built examples:

- **Why templates?**: They demonstrate common patterns and best practices for encrypted operations, such as governance, token standards, and utility contracts.

For more details, explore the [fhevm-contracts documentation](../../smart_contracts/contracts.md).

### 8.
