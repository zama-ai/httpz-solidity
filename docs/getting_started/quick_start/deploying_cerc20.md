# Step 3: Deploying **ConfidentialERC20**

In this tutorial, you'll learn how to deploy a confidential token contract using Zama's **fhEVM**. We'll create `MyConfidentialERC20.sol` to demonstrate the essential features.

## Prerequisites

Ensure the following before deploying the smart contract:

- The **Zama Plugin** installed is installed in the Remix IDE(see [Step 1](./remix.md)).
- Your **wallet** is connected to the **Sepolia testnet**(see [Step 2](./connect_wallet.md)).

## Set up the contract file

First, let's create a file for our confidential ERC20 contract:

1. Open the **Remix IDE**.
2. Navigate to the **contracts** folder.
3. Click the **Create new file** icon.
4. Name the file `MyConfidentialERC20.sol` and press Enter.

![File creation](https://colony-recorder.s3.amazonaws.com/files/2025-01-29/0c213215-e42d-4c67-af99-01692d04752f/stack_animation.webp)

## Basic contract structure

The foundational structure includes importing Zama's libraries and connecting to Sepolia's fhEVM configuration.

Copy the following code in the `MyConfidentialERC20.sol` that you just created:

```solidity
// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";
import "fhevm/config/ZamaFHEVMConfig.sol";

contract MyConfidentialERC20 is SepoliaZamaFHEVMConfig {}
```

It should appear as follows:

![Auto-import in Remix](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-16/98f850d2-b303-4ba7-89e8-9db3fba9773c/ascreenshot.jpeg)

Remix automatically saves any changes as you type. Upon saving, it imports the following libraries:

- **`TFHE.sol`**: The core Solidity library of Zama's fhEVM. It enables encrypted data type like `euint64`, secures encrypted operations, such as addition and comparison and allows access control.
- **`SepoliaZamaFHEVMConfig`**: A configuration contract that automatically sets up the required configurations for real-time encrypted operations on the Sepolia testnet.

## Enhancing functionality

Next, we'll enhance our contract by importing the `fhevm-contracts` library.

{% hint style="info" %}
The **fhevm-contracts** is a Solidity library designed for developers to easily develop confidential smart contracts using fhEVM. It provides:

- **Ready-to-use confidential contracts**: Pre-built implementations of common token standards with FHE capabilities
- **Base contracts**: Foundational building blocks for creating custom confidential smart contracts
- **Extensions**: Additional features and utilities that can be added to base contracts
- **Testing utilities**: Tools to help test FHE-enabled smart contracts

See more details in [the fhEVM-contracts documentation](../../smart_contracts/contracts.md).
{% endhint %}

The `fhevm-contracts` library includes the `ConfidentialERC20Mintable` contract, which is an extention of `ConfidentialERC20` with minting capabilities, providing:

- Private token transfers and encrypted balances
- Minting functionality for authorized addresses
- Full ERC20 compatibility

It inherits all base `ConfidentialERC20` features while adding secure token creation and distribution capabilities.

To use `ConfidentialERC20Mintable` contract, simply update your `MyConfidentialERC20.sol` with the following code:

```solidity
// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.24;

import "fhevm/lib/TFHE.sol";
import "fhevm/config/ZamaFHEVMConfig.sol";
import "fhevm-contracts/contracts/token/ERC20/extensions/ConfidentialERC20Mintable.sol";

contract MyConfidentialERC20 is SepoliaZamaFHEVMConfig, ConfidentialERC20Mintable {
  constructor(string memory name_, string memory symbol_) ConfidentialERC20Mintable(name_, symbol_, msg.sender) {}
}
```

It should appear as follows:

![Mintable token implementation](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-28/8e41246a-5041-4b29-914f-5e5442b45877/ascreenshot.jpeg?tl_px=0,0&br_px=2752,1538&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=0.7&wat_gravity=northwest&wat_url=https://colony-recorder.s3.us-west-1.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=356,140)

## Compiling the contract

Now the contract is ready, the next step is to compile it:

1. Select `MyConfidentialERC20.sol`.
2. Go to **Solidity compiler** in Remix.
3. Click **Compile**.

If successful, you will see a green checkmark on the Solidity Compiler, indicating "Compilation successful"

![Compile contract](https://colony-recorder.s3.amazonaws.com/files/2025-01-28/acb729d3-655c-4360-88ef-2fde8f71b4ba/stack_animation.webp)

## Deployment

Before deploying the contract, you need to set up the environment first:

1. Navigate to **Deploy & run transactions** in Remix.
2. Under **Environment**: Select "Injected Provider - MetaMask".
3. In **Account**: Choose the address of your MetaMask wallet connected to the Sepolia testnet.

![Setup deployment](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/6bbcfe82-5db4-4a6a-b58e-c21c7e0a5034/stack_animation.webp)

Now the contract is ready to be deployed:

1. Expand the **Deploy** section.
2. Fill the constructor parameters:
   - **Name**: Your token’s name (e.g., "My Private Token").
   - **Symbol**: Token symbol (e.g., "MPT").
3. Click **Transact** and confirm the transaction in MetaMask.

![Deploy contract](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/ad5f896e-a394-449e-bd6f-be37fff251a6/stack_animation.webp)

Once successfully deployed, your contract will appear under **Deployed Contracts**.

![Deploy contract](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-16/3685296f-0a0a-46bd-9c2f-4cb9320e47d3/ascreenshot.jpeg?tl_px=0,752&br_px=1719,1714&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=66,466)

You can also view your contract on Etherscan by clicking the contract address.

![View contract](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-16/bb6ad6b9-f166-4fc1-9358-15363592ad46/ascreenshot.jpeg?tl_px=64,752&br_px=1784,1714&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=524,392)

---

By following these steps, you’ve successfully created and deployed an confidential ERC-20 token using Zama's fhEVM!🎉 Let's see how the transaction works in the next chapter.
