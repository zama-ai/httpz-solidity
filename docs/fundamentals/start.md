# **Start creating confidential smart contracts**

Welcome to your first steps in writing Solidity smart contracts! This guide walks you through creating and deploying your first confidential smart contract using the `fhEVM`. After setting up your development environment, we’ll dive straight into coding.

## **Your First Contract**

Let’s create a simple **Encrypted Counter** smart contract. This contract demonstrates the basics of using the `TFHE` library to manage encrypted state variables and perform encrypted computations.

### **Writing the Contract**

Create a new file called `EncryptedCounter1.sol` in your `contracts/` folder and add the following code:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";

contract EncryptedCounter1 {
    euint8 counter; // Encrypted 8-bit counter

    constructor() {
        TFHE.setFHEVM(FHEVMConfig.defaultConfig());

        // Initialize counter with an encrypted zero value
        counter = TFHE.asEuint8(0);
        TFHE.allowThis(counter); // Allow the contract to manipulate this ciphertext
    }

    function increment() public {
        // Perform encrypted addition to increment the counter
        counter = TFHE.add(counter, TFHE.asEuint8(1));
    }

    function getCounter() public view returns (euint8) {
        // Return the encrypted counter value
        return counter;
    }
}
```

## **How It Works**

1. **State Variable**:  
   The `counter` is an encrypted 8-bit integer (`euint8`), ensuring its value is confidential.

2. **Initialization**:  
   In the constructor:
   - The counter is initialized to an encrypted `0` using `TFHE.asEuint8(0)`.
   - `TFHE.allowThis(counter)` allows the contract to manipulate the ciphertext.

3. **Increment Function**:  
   The `increment()` function adds an encrypted `1` to the counter using `TFHE.add`.

4. **Getter Function**:  
   The `getCounter()` function returns the encrypted counter. The value remains encrypted and requires authorized decryption to interpret.

## **Next Steps**

Congratulations! You’ve written, deployed, and interacted with your first encrypted smart contract. Explore these next steps to deepen your understanding:

- **Add Decryption**: Integrate decryption logic in your frontend using the `fhevmjs` library.  
- **Extend the Counter**: Add features like decrementing the counter or resetting it to a specific value.  
- **Explore Advanced Use Cases**: Learn about encrypted operations, access control, and handling more complex logic with the `TFHE` library.

For more information, refer to the [fhEVM documentation](https://docs.zama.ai/fhevm).