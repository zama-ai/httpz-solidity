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

# Create a smart contract

This document introduces the fundamentals of writing confidential smart contracts using the fhEVM. You'll learn how to create contracts that can perform computations on encrypted data while maintaining data privacy.

In this guide, we'll walk through creating a basic smart contract that demonstrates core fhEVM concepts and encrypted operations.

## Your first smart contract

Let’s build a simple **Encrypted Counter** smart contract to demonstrate the configuration process and the use of encrypted state variables.

### Writing the contract

Create a new file called `ConfidentialCounter.sol` in your `contracts/` folder and add the following code:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";
import { SepoliaZamaFHEVMConfig } from "fhevm/config/ZamaFHEVMConfig.sol";

// declare the configuration
contract ConfidentialCounter1 is SepoliaZamaFHEVMConfig {
  euint8 internal counter;

  function increment() public {
    // Perform encrypted addition to increment the counter
    counter = TFHE.add(counter, 1);
    // Allow this enables our contract to the encrypted variable
    TFHE.allowThis(counter);
  }
}
```

#### How it works

1.  **Configuring fhEVM**:\
    The contract inherits from `SepoliaZamaFHEVMConfig` which provides the necessary configuration for local development and testing. This configuration includes the addresses of the TFHE library and Gateway contracts.

    When deploying to different networks, you can use the appropriate configuration:

    ```solidity
    // For Sepolia testnet
    import { SepoliaZamaFHEVMConfig } from "fhevm/config/ZamaFHEVMConfig.sol";
    contract MyContract is SepoliaZamaFHEVMConfig { ... }
    ```

    The configuration handles setting up:

    - TFHE library address for encrypted operations
    - Network-specific parameters

2.  **Initializing encrypted variables**:
    - The `counter` variable is set to an encrypted `0` using `TFHE.asEuint8(0)`.
    - Permissions are granted to the contract itself for the `counter` ciphertext using `TFHE.allowThis(counter)`.
    - A constant `CONST_ONE` is initialized as an encrypted value to represent the number `1`.
3.  **Encrypted operations**:\
    The `increment()` function adds the encrypted constant `CONST_ONE` to the `counter` using `TFHE.add`.

### Next steps:

There are two notable issues with this contract:

1. **Counter value visibility**:\
   Since the counter is incremented by a fixed value, observers could deduce its value by analyzing blockchain events. To address this, see the documentation on:
   - [encryption and secure inputs](../fundamentals/inputs.md)
2. **Access control for `counter`**:\
   The counter is encrypted, but no access is granted to decrypt or view its value. Without proper ACL permissions, the counter remains inaccessible to users. To resolve this, refer to:
   - [decryption](../fundamentals/decryption/decrypt.md)
   - [re-encryption](../fundamentals/decryption/reencryption.md)
