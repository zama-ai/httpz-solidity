# Step 1: Setting Up Remix

This guide helps you set up the **Zama Plugin** in the official Remix IDE, enabling seamless development and management of smart contracts using the **fhEVM**.

## Prerequisites

Before starting, make sure you have the following:
- A web **browser** (such as Chrome, Firefox).
- Basic familiarity with **Ethereum smart contracts**.
- A crypto **wallet** (we recommend using **MetaMask** for this tutorial).

## Connecting to the Zama Plugin in Remix
**Zama Plugin** allows you to interact with confidential contracts directly within Remix. To set it up:

1. Open the **Remix IDE** by navigating to [https://remix.ethereum.org](https://remix.ethereum.org).
2. In the left sidebar, click on the **Plugin Manager**.
3. In the Plugin Manager, select **Connect to a Local Plugin**.

![Connect to Zama Plugin](https://colony-recorder.s3.amazonaws.com/files/2025-01-28/0c7520ae-e771-41c5-a5c3-b72d10e236ec/stack_animation.webp)

## Installing the Zama Plugin

Use the following configurations:

   - **Plugin Name** (required) : Enter `Zama`.
   - **URL**(required): Enter `https://remix.zama.ai/`.
   - **Type of connection**(required): Select `Iframe`
   - **Location in remix** (required):Select `Side Panel`
   - Click `OK`.

![Install Zama Plugin](https://colony-recorder.s3.amazonaws.com/files/2025-01-16/b8df3384-d3b1-4845-8205-a23206081051/stack_animation.webp)


## Configuring the Zama Plugin
**Zama Plugin** provides the **Zama Coprocessor - Sepolia configuration** that ensures Remix and the wallet are properly set up to interact with fhEVM smart contracts.

To complete the configuration:
1. Click the **Zama Plugin** icon in the sidebar to open it.
2. In the configuration screen, select **Zama Coprocessor - Sepolia**.
3. Click **Use this configuration** to finalize the setup.

Once successful, you should see the green text in the terminal indicating that the configuration is ready.

![Configuring Zama Plugin](https://colony-recorder.s3.amazonaws.com/files/2025-01-28/3b532cb8-8dba-44ab-a082-bedaa2465348/stack_animation.webp)
 

---
Now that you've configured the plugin, you are able to deploy and interact with **fhEVM** encrypted contracts directly directly via Remix interface. Next, let's dive into the contract deployment.
