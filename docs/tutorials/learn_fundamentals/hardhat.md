# 1. Setting up Hardhat

This guide will help you set up a development environment for building privacy-preserving smart contracts using the Fully Homomorphic Encryption Virtual Machine (FHEVM) with Hardhat.

<iframe src="https://scribehow.com/embed/Get_started_with_Hardhat__1fcheHVgTIuGETSdEBRmkw?skipIntro=true&removeLogo=true" width="100%" height="640" allowfullscreen frameborder="0"></iframe>

## Prerequisites

- Node.js (v20 or later)
- npm, yarn, or pnpm package manager
- Git

## Getting Started

1. Clone the template repository:

   ```bash
   git clone https://github.com/zama-ai/fhevm-hardhat-template
   cd fhevm-hardhat-template
   ```

2. Set up your environment:

   ```bash
   cp .env.example .env
   ```

3. Install dependencies using your preferred package manager:

   ```bash
   # Using npm
   npm install

   # Using yarn
   yarn install

   # Using pnpm
   pnpm install
   ```

## Development Workflow

- Place your smart contracts in the `contracts/` directory
- Place your tests under the `tests/` directory

### Testing

Run the test suite using:

```bash
pnpm test
```

## Deployment to Sepolia Testnet

Follow these steps to deploy your contracts to the Sepolia testnet:

1. Generate a wallet:

   ```bash
   cast wallet new-mnemonic
   ```

   Copy the generated mnemonic seed phrase to your `.env` file.

2. Set up RPC access:

   - Get an RPC URL from [Alchemy](https://www.alchemy.com/) or [Infura](https://www.infura.io/)
   - Add it to your `.env` file as `SEPOLIA_RPC_URL`

3. Verify your accounts:

   ```bash
   npx hardhat get-accounts --num-accounts 5
   ```

   This will show the addresses that will be used for deployment.

4. Deploy your contracts:

   ```bash
   pnpm deploy-sepolia
   ```

5. Once deployed, you can view your contract on [Sepolia Etherscan](https://sepolia.etherscan.io/)
