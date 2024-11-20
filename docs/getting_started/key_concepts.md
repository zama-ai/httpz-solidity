# Key concepts and features

<figure><img src="../.gitbook/assets/doc_header_fhevm.png" alt=""><figcaption></figcaption></figure>

## **1. Introduction**
The Fully Homomorphic Ethereum Virtual Machine (fhEVM) is a groundbreaking protocol enabling **confidential smart contracts** on EVM-compatible blockchains. By leveraging Fully Homomorphic Encryption (FHE), fhEVM ensures complete data privacy without sacrificing composability or usability.


## **2. Core Principles**
The design of fhEVM is guided by the following principles:
1. **Preserving Security**: No impact on the underlying blockchain’s security guarantees.
2. **Public Verifiability**: All computations are publicly verifiable while keeping data confidential.
3. **Developer Accessibility**: Build confidential smart contracts using familiar Solidity tooling, without requiring cryptographic expertise.
4. **Composability**: Confidential smart contracts are fully interoperable with each other and public contracts.


## **3. Key Features**

### **3.1.1 Encrypted Data Types**
fhEVM introduces encrypted data types compatible with Solidity:
- **Booleans**: `ebool`
- **Unsigned Integers**: `euint4`, `euint8`, `euint16`, `euint32`, `euint64`, `euint128`, `euint256`
- **Addresses**: `eaddress`
- **Bytes**: `ebytes64`, `ebytes128`, `ebytes256`
- **Input**: `einput` for handling encrypted input data

Encrypted data is represented as ciphertext handles, ensuring secure computation and interaction.

For more information see [use of encrypted types](../fundamentals/types/README.md).

### **3.1.2 Casting Types**
fhEVM provides functions to cast between encrypted types:
- **Casting between encrypted types**: `TFHE.asEbool` converts encrypted integers to encrypted booleans
- **Casting to encrypted types**: `TFHE.asEuintX` converts plaintext values to encrypted types
- **Casting to encrypted addresses**: `TFHE.asEaddress` converts plaintext addresses to encrypted addresses
- **Casting to encrypted bytes**: `TFHE.asEbytesX` converts plaintext bytes to encrypted bytes

For more information see [use of encrypted types](../fundamentals/types/README.md).


### **3.2 Confidential Computation**
fhEVM enables symbolic execution of encrypted operations, supporting:
- Arithmetic: `TFHE.add`, `TFHE.sub`, `TFHE.mul`, `TFHE.min`, `TFHE.max`, `TFHE.neg`, `TFHE.div`, `TFHE.rem`
  - Note: `div` and `rem` operations are supported only with plaintext divisors
- Bitwise: `TFHE.and`, `TFHE.or`, `TFHE.xor`, `TFHE.not`, `TFHE.shl`, `TFHE.shr`, `TFHE.rotl`, `TFHE.rotr`
- Comparison: `TFHE.eq`, `TFHE.ne`, `TFHE.lt`, `TFHE.le`, `TFHE.gt`, `TFHE.ge`
- Advanced: `TFHE.select` for branching on encrypted conditions, `TFHE.randEuintX` for on-chain randomness.

For more information on operations, see [Operations on encrypted types](../fundamentals/types/operations.md).
For more information on conditional branching, see [Conditional logic in FHE](../fundamentals/types/conditions.md).
For more information on random number generation, see [Generate Random Encrypted Numbers](../fundamentals/types/random.md).


### **3.3 Access Control Mechanism**
fhEVM enforces access control with a blockchain-based Access Control List (ACL):
- **Persistent Access**: `TFHE.allow`, `TFHE.allowThis` grants permanent permissions for ciphertexts.
- **Transient Access**: `TFHE.allowTransient` provides temporary access for specific transactions.
- **Validation**: `TFHE.isSenderAllowed` ensures that only authorized entities can interact with ciphertexts.

For more information see [ACL](../fundamentals/acl.md)


## **4. Architectural Overview**

The fhEVM (Fully Homomorphic Ethereum Virtual Machine) represents a transformative protocol designed to bring confidentiality and security to blockchain-based computations while preserving public verifiability. Below, we delve deeply into its architectural components and workflows.

---

## **1. High-Level Design**
The fhEVM merges cutting-edge cryptographic techniques to ensure confidentiality and composability of smart contracts:
- **Fully Homomorphic Encryption (FHE)**: Enables computations directly on encrypted data without decryption.
- **Threshold Multi-Party Computation (MPC)**: Distributes key management across multiple entities to prevent single points of failure.
- **Zero-Knowledge Proofs of Knowledge (ZKPoK)**: Ensures correctness of encrypted inputs without revealing the plaintext.

The protocol is compatible with Ethereum and other EVM-compatible blockchains and offers flexibility with two deployment variants:
1. **fhEVM-native**: Integrated into Layer 1/2/3 blockchains.
2. **fhEVM-coprocessor**: Works as an off-chain service for non-native EVM systems.

For a detailed exploration of the fhEVM architecture, including components, workflows, and deployment models, see [Architecture Overview](../fundamentals/architecture_overview.md).