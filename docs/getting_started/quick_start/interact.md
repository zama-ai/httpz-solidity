# Step 4: Interacting with Your Contract

After deploying your first **fhEVM** contract using **Remix**, this guide shows you how to interact with it directly in Remix using the **Zama Plugin**.

## Prerequisite

Before interacting with your deployed contract, ensure the following:

- **Deployment completed**: You have successfully deployed the `MyConfidentialERC20` contract (see [Step 3](./deploying_cerc20.md)).
- **MetaMask wallet**: Your MetaMask wallet is connected to the Sepolia testnet(see [Step 2](./connect_wallet.md)). You have at least 2 accounts to perform token transactions.
- **Zama Plugin in Remix**: The Zama Plugin is installed and accessible in Remix (see [Step 1](./remix.md)).

## Connect the deployed contract

To perform transactions directly in Remix, your contract needs to be connected to the **Zama Plugin**:

1. In "**Deployed Contract**", copy the address of the `MYCONFIDENTIALERC20` contract that you just deployed.
2. Open the **Zama Plugin** from the side menu.
3. Paste the contract address into the **"At address"** field under the **Deploy** section.
4. Click **At address**.

![Connect the contract](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/3adc23b0-4914-40fd-97b7-2f251b905e8b/stack_animation.webp)

## Verify the connection

If the address was entered correctly, the `MyConfidentialERC20.sol` contract will be displayed in the "**Deployed Contract**" inside the **Zama Plugin**.

Click the contract to expand, you will see all the features that you can interact with.

![Contract visibility](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-16/1adf1fef-d2f0-432c-85b2-8a0dcdd9f38c/ascreenshot.jpeg)

`ConfidentialERC20Mintable` supports all standard ERC-20 functions, but adapted for encrypted values, including:

- `transfer`: Securely transfers encrypted tokens.
- `approve`: Approves encrypted amounts for spending.
- `transferFrom`: Transfers tokens on behalf of another address.
- `balanceOf`: Returns the encrypted balance of an account.
- `totalSupply`: Returns the total token supply.

## Mint tokens to your account

From here, you can mint confidential ERC20 token to your account:

1. Click to expand the **mint** function.
2. Enter your wallet address.
3. Specify the amount of tokens to mint (e.g., `10000`).
4. Click `Submit`.
5. Confirm the transaction in **MetaMask**.

![Mint tokens](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/16476b39-2740-48ad-bcb8-7780035656e4/stack_animation.webp)

## Verify total supply

After a successful mint transaction, click the **totalSupply** to reflect the minted tokens (e.g., `10000`).

![Verify total supply](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/7487004f-40bd-4455-9f00-f484da918a8f/stack_animation.webp)

## 5. Check your balance

To verify your account balance:

1. Click to expand the **balanceOf** function.
2. Enter your wallet address.
3. Click `Submit` to verify your account balance.

Your balance is stored as encrypted data using FHE. No one else can view if except you.

To view the balance in plaintext:

- Click the **re-encrypt** option
- Confirm the transaction in Metamask

You can see that the ciphertext is decrypted and your balance is the amount that you just minted.

![Check balance](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/999cd003-f088-449c-978a-9ed1b158e00e/stack_animation.webp)

## 6. Transfer tokens

To transfer confidential ERC20 tokens to another account:

1. Click **transfer** to expand the function, set the following parameters:

   - **To**: Enter the wallet address of the recipient.
   - **encryptedAmount**: Specify the amount that you want to transfer (e.g.`1000`). Choose `euint64`.
   - **inputProof**: Check the **input** box.

2. Click **Submit** to proceed.
3. Confirm the transaction in **MetaMask**.

![Transfer tokens](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/de6141a7-4e85-4bb0-a5fd-9cc0e44807c1/stack_animation.webp)

## 7. Verify updated balance

After making a transfer, you can verify your updated account balance:

1. Use the **balanceOf** function again to check your updated balance (see the [Step 5: Check your balance](#5-check-your-balance).)
2. Perform **re-encryption** to confirm the changes, you should see the remaining token in your account.(e.g., `9000` tokens remaining).

![Verify updated balance](https://colony-recorder.s3.amazonaws.com/files/2025-01-17/41be5952-5036-41ed-b0c6-be78b3490275/stack_animation.webp)

{% hint style="info" %} Always re-encrypt to validate ciphertext transformations and confirm operations. {% endhint %}

## Next steps

🎉 **Congratulations on completing this tutorial!** You’ve taken the first step in building confidential smart contracts using **fhEVM**. It's time now to take the next step and build your own confidential dApps!

### Resources

To continue your journey and deepen your knowledge, explore the resources below.

- **[Read the Whitepaper](https://github.com/zama-ai/fhevm/blob/main/fhevm-whitepaper-v2.pdf)**: Understand the core technology behind fhEVM, including its cryptographic foundations and use cases.
- **[See more demos and tutorials](<(../../tutorials/see-all-tutorials.md)>)**: Expand your skills with hands-on demos and tutorials crafted to guide you through various real-world scenarios.
- [**Try out AI coding assistant**](https://chatgpt.com/g/g-67518aee3c708191b9f08d077a7d6fa1-zama-solidity-developer): If you have a chatGPT plus account, try out our custom ChatGPT model tailored for Solidity and fhEVM developers.

### Tools

Use out-of-box templates and frameworks designed for developers to build confidential dapps easily.

**Smart contract development**

- [**Hardhat Template**](https://github.com/zama-ai/fhevm-hardhat-template): A developer-friendly starting point for building and testing smart contracts on fhEVM.
- [**fhEVM Contracts Library**](https://github.com/zama-ai/fhevm-contracts): Access standardized contracts for encrypted operations.

**Frontend development**

- [**React.js Template**](https://github.com/zama-ai/fhevm-react-template): Quickly develop FHE-compatible dApps using a clean React.js setup.
- [**Next.js Template**](https://github.com/zama-ai/fhevm-next-template): Build scalable, server-rendered dApps with FHE integration.
- [**Vue.js Template**](https://github.com/zama-ai/fhevm-vue-template): Develop responsive and modular dApps with FHE support in Vue.js.

### Community

Join the community to shape the future of blockchain together with us.

- [**Discord**](https://discord.gg/zama-ai): Join the community to get the latest update, have live discussion with fellow developers and Zama team.
- [**Community Forum**](https://community.zama.ai/): Get support on all technical questions related to fhEVM
- [**Zama Bounty Program**](https://github.com/zama-ai/bounty-program): Participate to tackle challenges and earn rewards in cash.
- [**Developer Survey**](https://zama.ai/survey): Share your feedback to help us improve the protocol.
