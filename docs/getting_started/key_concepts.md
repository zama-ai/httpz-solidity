# Overview

<figure><img src="../.gitbook/assets/doc_header_fhevm.png" alt=""><figcaption></figcaption></figure>

## Introduction

fhEVM is a protocol enabling **confidential smart contracts** on EVM-compatible blockchains. By leveraging Fully Homomorphic Encryption (FHE), fhEVM ensures complete data privacy without sacrificing composability or usability.

## Core principles

The design of fhEVM is guided by the following principles:

1. **Preserving security**: No impact on the underlying blockchain's security guarantees.
2. **Public verifiability**: All computations are publicly verifiable while keeping data confidential.
3. **Developer accessibility**: Build confidential smart contracts using familiar Solidity tooling, without requiring cryptographic expertise.
4. **Composability**: Confidential smart contracts are fully interoperable with each other and public contracts.

## Use cases

fhEVM enables a wide range of privacy-preserving applications across different domains:

1. **Decentralized Finance (DeFi)**

   - Private token balances and transfers
   - Confidential lending and borrowing
   - Dark pools and private order books
   - Example: [Confidential ERC20 tutorial](../tutorials/confidentialERC20.md)

2. **Gaming & NFTs**

   - Hidden game states and player moves
   - Private NFT ownership and metadata
   - Sealed bid auctions
   - Example: [Rock Paper Scissors tutorial](https://github.com/zama-ai/fhevm-tutorial-rock-paper-scissors)

3. **Identity & Access Control**

   - Zero-knowledge authentication
   - Private membership verification
   - Confidential access management
   - Example: [Private voting tutorial](https://github.com/zama-ai/fhevm-tutorial-private-voting)

4. **Business Applications**
   - Supply chain privacy
   - Confidential business logic
   - Private data marketplaces
   - Example: [Sealed bid auction tutorial](https://github.com/zama-ai/fhevm-tutorial-sealed-bid-auction)

These applications demonstrate how fhEVM enables previously impossible use cases by combining blockchain transparency with data privacy.
