# Configuring your smart contract for encrypted computations  

This document describes how to enable encrypted computations in your smart contract by setting up the `fhEVM` environment. This involves configuring essential functions and integrating specific libraries to handle encrypted data securely and efficiently.

---

## Workflow for writing confidential smart contracts  

1. **Use the Hardhat Template**:  
   Start with our custom [`fhevm-hardhat-template` repository](https://github.com/zama-ai/fhevm-hardhat-template). Hardhat is a powerful development environment for Solidity, allowing you to write, test, and deploy contracts to the `fhEVM` using TypeScript.

2. **Begin with Unencrypted Logic**:  
   Develop your contract as if it were intended for a traditional EVM chain. Use cleartext variables and basic logic, which simplifies reasoning about the contract’s functionality.

3. **Add Encryption**:  
   Integrate the `TFHE` Solidity library to enable encryption. Convert sensitive variables (e.g., `uintX`) into encrypted types (e.g., `euintX`) to ensure confidentiality. Refer to the [pitfalls to avoid and best practices](../../guides/pitfalls.md) guide for detailed advice.  
   For inspiration, check out the examples in the [`fhevm` contracts repository](https://github.com/zama-ai/fhevm-contracts).  

---

## Core configuration functions  

Below are the key configuration functions needed to enable encrypted operations in your contract.

### `setFHEVM`  

This function initializes the FHEVM environment with the required configuration.  

```solidity
function setFHEVM(FHEVMConfig.FHEVMConfigStruct memory fhevmConfig) public
```  

- **Purpose**: Sets encryption parameters, including cryptographic keys and supported ciphertext types.  
- **Usage**: Call this function in the constructor to ensure proper initialization.  
- **Default Configuration**: Use `FHEVMConfig.defaultConfig()` for a standard encryption setup.  

#### Example  

```solidity
constructor() {
    // Initialize the FHEVM environment with default settings
    TFHE.setFHEVM(FHEVMConfig.defaultConfig());
}
```  

---

### `isInitialized`  

This utility function verifies whether a given encrypted variable is initialized.  

```solidity
function isInitialized(T v) internal pure returns (bool)
```  

- **Purpose**: Prevents uninitialized encrypted variables from being used, avoiding unexpected behavior.  
- **Usage**: Use this check in critical functions or constructors.  

#### Example  

```solidity
require(TFHE.isInitialized(counter), "Counter not initialized!");
```

---

### `setGateway`  

When performing decryption or re-encryption, you must configure the contract to interact with the `Gateway`.  

```solidity
Gateway.setGateway(Gateway.defaultGatewayAddress());
```  

The Gateway serves as the bridge between the blockchain, coprocessor, and KMS for secure cryptographic operations.

#### Example  

```solidity
import "fhevm/lib/TFHE.sol";
import "fhevm/gateway/GatewayCaller.sol";

contract Test is GatewayCaller {
    constructor() {
        // Set up the FHEVM and Gateway configurations
        TFHE.setFHEVM(FHEVMConfig.defaultConfig());
        Gateway.setGateway(Gateway.defaultGatewayAddress());
    }
}
```  