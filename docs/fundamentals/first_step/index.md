# Workflow for writing confidential smart contracts  

This document outlines the essential steps for developing secure and efficient confidential smart contracts using `fhEVM`. By following this workflow, you can streamline the process and ensure best practices are implemented throughout your project.  

## Step-by-Step Workflow  

### 1. Use the Hardhat template  
Begin with our custom [`fhevm-hardhat-template` repository](https://github.com/zama-ai/fhevm-hardhat-template).  
- **Why Hardhat?**: It is a powerful Solidity development environment, offering tools for writing, testing, and deploying contracts to the `fhEVM` using TypeScript.  
- **Benefit**: The template provides a pre-configured setup tailored to confidential smart contracts, saving development time and ensuring compatibility.  

---

### 2. Configure the contract  
Choose and inherit the correct configuration based on the environment:  
- **Mock Network**: For local testing and development.  
- **Testnets (e.g., Sepolia)**: For deploying to public test networks.  
- **Mainnet**: When deploying to production.  

Ensure configuration contracts (e.g., `MockZamaFHEVMConfig`, `SepoliaZamaFHEVMConfig`) are inherited correctly to initialize encryption parameters, cryptographic keys, and Gateway addresses.  

---

### 3. Begin with unencrypted Logic  
Develop your contract as you would for a traditional EVM chain:  
- Use cleartext variables and basic logic to simplify debugging and reasoning about the contract’s behavior.  
- Focus on implementing core functionality without adding encryption initially.  

---

### 4. Add Encryption  
Once the logic is stable, integrate the `TFHE` Solidity library to enable encryption:  
- **Convert Sensitive Variables**: Replace plaintext types like `uintX` with encrypted types such as `euintX`.  
- **Enable Confidentiality**: Encrypted variables and operations ensure sensitive data remains private while still being processed.  

---

### 5. Follow best practices  
Throughout the documentation, you'll find sections marked with 🔧 that highlight important best practices. These include:

🔧 **Optimized Data Types**  
- Use appropriately sized encrypted types (`euint8`, `euint16`, etc.) to minimize gas costs.  

🔧 **Scalar Operands**  
- Whenever possible, use scalar operands in operations to reduce computation and gas usage.  

🔧 **Overflow Handling**  
- Manage arithmetic overflows in encrypted operations using conditional logic (`TFHE.select`).  

🔧 **Secure Access Control**  
- Use `TFHE.allow` and `TFHE.isSenderAllowed` to implement robust ACL (Access Control List) mechanisms for encrypted values.  

🔧 **Reencryption Patterns**  
- Follow the recommended approaches for reencryption to share or repurpose encrypted data securely.  

---

### 6. Leverage example templates  
Use the [`fhevm-contracts repository`](https://github.com/zama-ai/fhevm-contracts) for pre-built examples:  
- **Why Templates?**: They demonstrate common patterns and best practices for encrypted operations, such as governance, token standards, and utility contracts.  
- **How to Use**: Extend or customize these templates to suit your application’s needs.  

For more details, explore the [fhevm-contracts documentation](../../guides/contracts.md).  

## Contract examples

Throughout these tutorials, you'll learn how to write secure confidential smart contracts using fhEVM. We'll use practical examples to demonstrate key concepts and best practices.

Our main example will be a `Counter.sol` contract that we'll progressively enhance to showcase:

- Basic encrypted state variables and operations
- Access control mechanisms
- Secure computation patterns
- Interaction between encrypted and unencrypted data
- Advanced FHE features and optimizations

Each iteration of the counter will build upon previous concepts while introducing new functionality, helping you understand how to develop robust confidential smart contracts.