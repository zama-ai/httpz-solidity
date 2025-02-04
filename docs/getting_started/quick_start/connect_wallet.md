# Step 2: Connect your wallet to Remix

In this guide, you'll learn how to connect your wallet and the **Zama Plugin** in Remix IDE to interact with fhEVM smart contracts.

## Prerequisites

Before starting, ensure you have the following:

- **MetaMask** or another Ethereum-compatible wallet installed.
- **Zama Plugin** installed in Remix IDE ([See Setting up Remix](remix.md))

## Connecting wallet to Remix

Follow the steps to connect your wallet to Remix:

1. Open Remix and navigate to **Deploy & run transactions**.
2. Under **Environment**, select **Injected Provider - MetaMask**.
3. MetaMask will prompt a connection request. Click **Connect** to proceed.
   <br>

![Connect wallet](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/821f9695-9c60-479e-9ce5-63d7d2e97daf/stack_animation.webp)

## Setting up Sepolia testnet

If you're using Metamask, the Sepolia testnet should be pre-configured. Follow the steps to set it up:

1. Open **MetaMask**.
2. Click the **network dropdown** at the top left corner, and select **Sepolia Test Network**.

If Sepolia isn’t visible:

1. Go to **Settings > Advanced**.
2. Toggle **Show test networks** to **ON**.

![Metamask configuration](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/68cafdfb-2210-4e06-b24a-f39ff96727a3/stack_animation.webp)

If Sepolia isn’t pre-configured in your wallet, add it manually:

1. Open your wallet’s **network settings**.
2. Click **Add Network** or **Add Network Manually**.
3. Enter the following details:

   - **Network Name**: `Sepolia`
   - **RPC URL**: (provided by your node provider, e.g., Alchemy or Infura)
   - **Chain ID**: `11155111`
   - **Currency Symbol**: `SepoliaETH`
   - **Block Explorer URL**: `https://sepolia.etherscan.io`

## Connecting to the Zama Plugin

Now your wallet needs to be connected to the **Zama Plugin**:

1. Open the **Zama Plugin** in Remix.
2. Click **Connect your wallet**.
3. When prompted by MetaMask, confirm the connection by clicking **Connect**.

![Connect Zama Plugin](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/213f4f6d-f0b7-4bae-be2d-d5e3b8f59ddd/stack_animation.webp)

## Verifying Sepolia ETH balance

Open MetaMask and ensure you have **Sepolia ETH** available. Typically, 0.1 SepoliaETH is sufficient for most transactions during testing.

If you don’t have enough ETH, use a **Sepolia faucet** to request free SepoliaETH for testing:

- [Alchemy Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
- [QuickNode Faucet](https://faucet.quicknode.com/ethereum/sepolia)

![Check Sepolia ETH](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/2cae3f4e-370a-4be0-a071-24b01745bcfc/stack_animation.webp)

---

Now that your wallet is connected and your SepoliaETH balance is ready, you can proceed to deploy the `ConfidentialERC20Mintable` contract!
