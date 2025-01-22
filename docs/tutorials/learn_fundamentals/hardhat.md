# 1. Setting up Hardhat

This guide will help you set up a development environment for building privacy-preserving smart contracts using the Fully Homomorphic Encryption Virtual Machine (FHEVM) with Hardhat.

## Prerequisites

- Node.js (v20 or later)
- npm, yarn, or pnpm package manager
- Git

## Getting Started

Learn how to write, test and deploy fhEVM specific smart contracts with Hardhat.

1\. Go to <https://github.com/zama-ai/fhevm-hardhat-template>

2\. Create a new repository from this template.

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-17/49d22a7e-bba5-4dee-b7f9-60d675970fa3/stack_animation.webp)

3\. [[git clone]] the repository you have created.

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-17/bbee17d3-aa84-45ce-92b7-4f9c44239711/stack_animation.webp)

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

![](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-17/6504ddf1-f841-48b6-a84e-ddc6946c1ae2/File.jpeg?tl_px=0,41&br_px=3024,1964&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=59,408)

## Development Workflow

- Place your smart contracts in the `contracts/` directory
- Place your tests under the `tests/` directory

![](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-20/03790808-a211-4b7d-a87f-1734305177b5/ascreenshot.jpeg?tl_px=0,18&br_px=1719,979&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=157,277)

### Testing

Run the test suite using:

```bash
pnpm test
```

![](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-17/2128ed01-f2c9-4a85-9fd7-4af37686e2af/ascreenshot.jpeg?tl_px=0,41&br_px=3024,1964&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=629,553)

7\. When ready to **deploy** type `cast wallet new-mnemonic` to generate a new mnemonic seed and copy it to the `.env` file.

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-20/93145686-0ef2-4636-a7ac-9bb25c8a43a6/stack_animation.webp)

8\. Add a `SEPOLIA_RPC_URL` from sites like Alchemy or Infura

![](https://ajeuwbhvhr.cloudimg.io/colony-recorder.s3.amazonaws.com/files/2025-01-20/05128377-e779-44bc-b177-a2159e766cd8/ascreenshot.jpeg?tl_px=416,0&br_px=2136,961&force_format=jpeg&q=100&width=1120.0&wat=1&wat_opacity=1&wat_gravity=northwest&wat_url=https://colony-recorder.s3.amazonaws.com/images/watermarks/FB923C_standard.png&wat_pad=909,169)

9\. Type `npx hardhat get-accounts --num-accounts 5` to see which accounts have been generated.

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-20/51576e45-72c9-492b-9c7e-0fb3c8393da4/stack_animation.webp)

10\. Import the first 2 accounts (alice and bob) and fund them

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-20/8009d260-6693-40f2-8117-0412fa7f6c39/stack_animation.webp)

11\. Deploy the contracts by running `pnpm deploy-sepolia`

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-20/2dd9fa0a-190a-46c2-b3be-12394bb4de1c/stack_animation.webp)

12\. Find the deployed contract on <https://sepolia.etherscan.io/>

![](https://colony-recorder.s3.amazonaws.com/files/2025-01-20/7c45e315-a133-4592-b856-3ebb85fb23a6/stack_animation.webp)

#### [Made with Scribe](https://scribehow.com/shared/Get_started_with_Hardhat__1fcheHVgTIuGETSdEBRmkw)
