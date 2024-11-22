# **Start Creating Confidential Smart Contracts**

Welcome to your first steps in writing Solidity smart contracts! This guide will introduce you to configuring your contract for encrypted operations using the `fhEVM`. After setting up your development environment, you will learn how to initialize and configure the `fhEVM` for confidential computations.

---

## Typical workflow for writing confidential smart contracts

1. Use our custom [`fhevm-hardhat-template` repository](https://github.com/zama-ai/fhevm-hardhat-template). Hardhat is a popular development environment for Solidity developers and lets you test and deploy your contracts to the fhEVM using TypeScript.

2. Start with an unencrypted version of the contract you want to implement, as you would usually do on a regular EVM chain. It is easier to reason first on cleartext variables before adding confidentiality.

3. When you're ready, add confidentiality by using the `TFHE` Solidity library. Typically, this involves converting some `uintX` types to `euintX`. Follow the detailed advices provided in the [pitfalls to avoid and best practises](../../guides/pitfalls.md) section of the documentation. For inspiration, refer to the examples inside the [`fhevm` contracts repository](https://github.com/zama-ai/fhevm-contracts). If you're using the Hardhat template, read the advices in the [Hardhat section](../../getting_started/write_contract/hardhat.md).

## Configuring your smart contract

To enable encrypted computations in your smart contract, you must configure the `fhEVM` environment. The core configuration involves setting up the FHEVM configuration using the `setFHEVM` function.

---

### Core configuration functions

#### 1. `setFHEVM`

This function sets the FHEVM configuration required for encrypted operations.

```solidity
function setFHEVM(FHEVMConfig.FHEVMConfigStruct memory fhevmConfig) public
```

- **Purpose**: Establishes the encryption parameters for the contract, such as cryptographic keys and supported ciphertext types.  
- **Usage**: Must be called during contract initialization, typically in the constructor.  
- **Default Configuration**: Use `FHEVMConfig.defaultConfig()` to apply the standard encryption setup.

#### Example usage in a constructor

```solidity
constructor() {
    // Initialize the FHEVM with default configuration
    TFHE.setFHEVM(FHEVMConfig.defaultConfig());
}
```

---

#### **2. `isInitialized`**

This internal utility function checks if a given variable is initialized.

```solidity
function isInitialized(T v) internal pure returns (bool)
```

- **Purpose**: Ensures that an encrypted variable is properly initialized before use.  
- **Usage**: Called internally to validate state variables.  

#### **Example Initialization Check**

```solidity
require(TFHE.isInitialized(counter), "Counter not initialized!");
```

---

## Your first contract

Let’s build a simple **Encrypted Counter** smart contract to demonstrate the configuration process and the use of encrypted state variables.

### Writing the contract

Create a new file called `EncryptedCounter.sol` in your `contracts/` folder and add the following code:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";

/// @title EncryptedCounter1
/// @notice A basic contract demonstrating the setup of encrypted types
/// @dev Uses TFHE library for fully homomorphic encryption operations
/// @custom:experimental This is a minimal example contract intended only for learning purposes
/// @custom:notice This contract has limited real-world utility and serves primarily as a starting point
/// for understanding how to implement basic FHE operations in Solidity
contract EncryptedCounter1 {
    euint8 counter;
    euint8 CONST_ONE;

    constructor() {
        TFHE.setFHEVM(FHEVMConfig.defaultConfig());

        // Initialize counter with an encrypted zero value
        counter = TFHE.asEuint8(0);
        TFHE.allowThis(counter);
        // Save on gas by computing the constant here
        CONST_ONE = TFHE.asEuint8(1);
        TFHE.allowThis(CONST_ONE);
    }

    function increment() public {
        // Perform encrypted addition to increment the counter
        counter = TFHE.add(counter, CONST_ONE);
        TFHE.allowThis(counter);
    }
}

```

## How it works

1. **Configuring fhevm**:  
   The constructor initializes the FHEVM environment with a default configuration using `TFHE.setFHEVM(FHEVMConfig.defaultConfig())`.

2. **Initializing encrypted variables**:  
   - The `counter` variable is set to an encrypted `0` using `TFHE.asEuint8(0)`.  
   - Permissions are granted to the contract itself for the `counter` ciphertext using `TFHE.allowThis(counter)`.  
   - A constant `CONST_ONE` is initialized as an encrypted value to represent the number `1`.  

3. **Encrypted operations**:  
   The `increment()` function adds the encrypted constant `CONST_ONE` to the `counter` using `TFHE.add`.

## 👀 Can you spot a problem with this contract?

There are two notable issues with this contract:

1. **Counter Value Visibility**:  
   Since the counter is incremented by a fixed value, observers could deduce its value by analyzing blockchain events. To address this, see the documentation on:  
   - [encryption and secure inputs](./inputs.md)

2. **Access Control for `counter`**:  
   The counter is encrypted, but no access is granted to decrypt or view its value. Without proper ACL permissions, the counter remains inaccessible to users. To resolve this, refer to:  
   - [decryption](./decrypt.md)  
   - [re-encryption](./reencryption.md)

## **Next Steps**

Congratulations! You’ve configured and written your first confidential smart contract. Here are some ideas to expand your knowledge:

- **Understand Initialization Checks**: Use `TFHE.isInitialized` to ensure all encrypted variables are properly initialized.  
- **Explore Advanced Configurations**: Customize the `FHEVMConfig` to suit specific encryption requirements.  
- **Add Functionalities**: Extend the contract by adding decrement functionality or resetting the counter.  
- **Integrate Frontend**: Learn how to decrypt and display encrypted data in a dApp using the `fhevmjs` library.

For more information, refer to the [fhEVM documentation](https://docs.zama.ai/fhevm).