
# Architecture Overvie

This document provides developers with the essential architectural concepts needed to start building with fhEVM. Rather than diving deep into implementation details, it focuses on the key components and principles that enable confidential smart contract development.

The goal is to give you just enough understanding of the architecture to begin coding effectively. For more detailed technical information, please refer to the other documentation sections.

## **1. What is Fully Homomorphic Encryption (FHE)?**

Fully Homomorphic Encryption (FHE) is an advanced cryptographic technique that allows computations to be performed directly on encrypted data, without the need for decryption. This ensures that data remains confidential throughout its entire lifecycle, even during processing.

With FHE:
- Sensitive data can be securely encrypted while still being useful for computations.
- The results of computations are encrypted, maintaining end-to-end privacy.

FHE operates using three types of keys, each playing a crucial role in its functionality:

### **1.1 Private Key**
- **Purpose**: - for securely decrypting results - Decrypts ciphertexts to recover the original plaintext.
- **Usage in fhEVM**: Managed securely by the Key Management System (KMS) using a threshold MPC protocol. This ensures no single entity ever possesses the full private key.

### **1.2 Public Key**
- **Purpose**: - for encrypting data. -  Encrypts plaintexts into ciphertexts.
- **Usage in fhEVM**: Shared globally to allow users and smart contracts to encrypt inputs or states. It ensures that encrypted data can be processed without revealing the underlying information.

### **1.3 Evaluation Key**
- **Purpose**: - for performing encrypted computations - Enables efficient homomorphic operations (e.g., addition, multiplication) on ciphertexts. 
- **Usage in fhEVM**: Provided to FHE nodes (on-chain validators or off-chain coprocessors) to perform computations on encrypted data while preserving confidentiality.

These three keys work together to facilitate private and secure computations, forming the foundation of FHE-based systems like fhEVM.

<figure><img src="../.gitbook/assets/keys_fhe.png" alt="FHE Keys Overview"><figcaption>Overview of FHE Keys and their roles</figcaption></figure>

---

## **2. Bringing FHE to Blockchain: From Library to fhEVM**

### **2.1 Building on Zama’s FHE Library**
At its core, the fhEVM is built on Zama’s high-performance FHE library, **TFHE-rs**, written in Rust. This library implements the TFHE (Torus Fully Homomorphic Encryption) scheme and is designed to perform secure computations on encrypted data efficiently. 

> **Info**:
> For detailed documentation and implementation examples on the `tfhe-rs` library, visit the [TFHE-rs documentation](https://docs.zama.ai/tfhe-rs).

However, integrating a standalone FHE library like TFHE-rs into a blockchain environment involves unique challenges. Blockchain systems demand efficient processing, public verifiability, and seamless interoperability, all while preserving their decentralized nature. To address these requirements, Zama designed the fhEVM, a system that bridges the computational power of TFHE-rs with the transparency and scalability of blockchain technology.

### **2.2 Challenges in Blockchain Integration**
Integrating FHE into blockchain systems posed several challenges that needed to be addressed to achieve the goals of confidentiality, composability, and scalability:

1. **Transparency and Privacy**: Blockchains are inherently transparent, where all on-chain data is publicly visible. FHE solves this by keeping all sensitive data encrypted, ensuring privacy without sacrificing usability.
2. **Public Verifiability**: On-chain computations need to be verifiable by all participants. This required a mechanism to confirm the correctness of encrypted computations without revealing their inputs or outputs.
3. **Composability**: Smart contracts needed to interact seamlessly with each other, even when operating on encrypted data.
4. **Performance and Scalability**: FHE computations are resource-intensive, and blockchain systems require high throughput to remain practical.


To overcome these challenges, Zama introduced a hybrid architecture for fhEVM that combines:

 - On-chain functionality for managing state and enforcing access controls.
 - Off-chain processing via a coprocessor to execute resource-intensive FHE computations.

This design leverages the strengths of both blockchain and cryptographic systems, enabling secure, scalable, and composable confidential smart contracts.

---

### **2.3 Steps to Create fhEVM**

#### **fhEVM Components Overview**

The fhEVM system is built around four main components, each playing a vital role in enabling private and composable smart contracts on EVM-compatible blockchains. Below is a summary of these components and their primary responsibilities:

| **Component**                | **Description**                                                                                      | **Key Functions**                                                                                     |
|-------------------------------|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **fhEVM Smart Contracts**     | Smart contracts deployed on the blockchain to manage encrypted data and interactions.                | Includes the Access Control List (ACL) contract, `TFHE.sol` Solidity library, and FHE-enabled smart contracts. |
| **Gateway**                   | An off-chain service that bridges the blockchain with the cryptographic systems like KMS and coprocessor. |  Acts as an intermediary to forward the necessary requests and results between the blockchain, the KMS, and users.             |
| **Coprocessor**               | An off-chain computational engine designed to execute resource-intensive FHE operations.             | Executes symbolic FHE operations, manages ciphertext storage, and ensures efficient computation handling. |
| **Key Management System (KMS)** | A decentralized cryptographic service that securely manages FHE keys and validates operations.         | Manages the global FHE key (public, private, evaluation), performs threshold decryption, and validates ZKPoKs. |


<figure><img src="../.gitbook/assets/architecture.png" alt="FHE Keys Overview"><figcaption>High level overview of the Architecture</figcaption></figure>

#### **Step 1: Establishing a Global FHE Key System**
Zama introduced a global FHE key for the network, which encrypts all inputs, contract states, and outputs. This unified key system ensures composability across smart contracts and simplifies the management of encrypted data.


### **2.2 Gateway**
The Gateway facilitates interaction between the blockchain, KMS, and developers:
- **API Functions**: Handles decryption, re-encryption, ciphertext storage, and proof verification.
- **Off-chain Relayer**: Manages complex cryptographic processes, abstracting them for developers.
This component ensures a seamless developer experience while maintaining trustless execution.

---

#### **Step 2: Offloading Computations to a Coprocessor**
The coprocessor offloads FHE computations and manages ciphertext storage:
- **Execution**: Handles computationally expensive FHE operations.
- **Data Storage**: Secures encrypted data either off-chain or in a dedicated on-chain database.
Deployment options include trusted services, optimistic rollups, or actively validated services (AVS), ensuring flexibility and scalability.


#### **Step 3: Implementing Symbolic Execution in Solidity**
fhEVM separates the blockchain transaction from the computational process:
- **Handles**: Operations on encrypted data return references rather than immediate results.
- **Lazy Execution**: Actual computations occur asynchronously, either on-chain or via the coprocessor.
This approach boosts throughput by offloading intensive tasks.

#### **Step 6: Designing a Decentralized Key Management System (KMS)**

The **Key Management System (KMS)** is responsible for securely managing the global FHE keys. It uses threshold Multi-Party Computation (MPC) to:
- Prevent single points of failure in key management.
- Distribute decryption operations across multiple nodes for security.
- Handle decryption, re-encryption, and ZKPoK verification.

#### **Step 4: Incorporating Zero-Knowledge Proofs of Knowledge (ZKPoKs)**
To ensure the integrity of encrypted inputs and outputs, Zama integrated **ZKPoKs** into the fhEVM. These proofs:
- Verify that encrypted inputs are correctly formed and correspond to known plaintexts.
- Confirm the correctness of computations without revealing sensitive data.


