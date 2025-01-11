# Table of contents

- [Welcome to fhEVM](README.md)
- [Whitepaper](https://github.com/zama-ai/fhevm/blob/main/fhevm-whitepaper-v2.pdf)

## Getting Started

- [Overview](getting_started/key_concepts.md)
- [Quick start](getting_started/ethereum.md)
- [First smart contract](getting_started/first_smart_contract.md)
- [Writing smart contract]()
  - [Using Hardhat](getting_started/write_contract/hardhat.md)
  - [Using Remix](getting_started/write_contract/remix.md)
  - [Using Foundry](getting_started/write_contract/foundry.md)
- [Writing frontend]()
  - [Using React.js](https://github.com/zama-ai/fhevm-react-template)
  - [Using Next.js](https://github.com/zama-ai/fhevm-next-template)
  - [Using Vue.js](https://github.com/zama-ai/fhevm-vue-template)
  - [Using Typescript](getting_started/write_frontend/typescript.md)

## Tutorials

- [Build with ConfidentialERC20 tutorial](tutorials/confidentialERC20.md)
- [See all tutorials](tutorials/see-all-tutorials.md)

## Smart contract

- [Configuration](fundamentals/configure.md)
- [FhEVM contracts](guides/contracts.md)
- [Supported types](fundamentals/types.md)
- [Operations on encrypted types](fundamentals/operations.md)
- [AsEbool, asEuintXX, asEaddress and asEbytesXX operations](fundamentals/asEXXoperators.md)
- [Access Control List](fundamentals/acl/README.md)
  - [ACL examples](fundamentals/acl/acl_examples.md)
- [Encrypted Inputs](fundamentals/inputs.md)
- [Decryption](fundamentals/decryption/README.md)
  - [Decryption](fundamentals/decryption/decrypt.md)
  - [Decryption in depth](fundamentals/decryption/decrypt_details.md)
  - [Re-encryption](fundamentals/decryption/reencryption.md)
- [If sentances](guides/loop.md)
- [Branching in FHE](guides/conditions.md)
- [Generate random numbers](guides/random.md)
- [Error handling](guides/error_handling.md)
- [Gas estimation](guides/gas.md)
- [Debug decrypt](guides/debug_decrypt.md)

## Frontend

- [Build a web application](guides/frontend/webapp.md)
- [Build with Node](guides/frontend/node.md)
- [Using the CLI](guides/frontend/cli.md)
- [Common webpack errors](guides/frontend/webpack.md)

## Explanations

- [FHE on blockchain](fundamentals/architecture_overview/fhe-on-blockchain.md)
- [fhEVM components](fundamentals/architecture_overview/fhevm-components.md)
- [Encryption, decryption, re-encryption, and computation](fundamentals/d_re_ecrypt_compute.md)

## References

- [Smart contracts - fhEVM API](references/functions.md)
- [Frontend - fhevmjs lib](references/fhevmjs.md)
- [Repositories](getting_started/repositories.md)

## Developer

- [Contributing](developer/contribute.md)
- [Development roadmap](developer/roadmap.md)
- [Release note](https://github.com/zama-ai/fhevm/releases)
- [Feature request](https://github.com/zama-ai/fhevm/issues/new?assignees=&labels=enhancement&projects=&template=feature-request.md&title=)
- [Bug report](https://github.com/zama-ai/fhevm/issues/new?assignees=&labels=bug&projects=&template=bug_report_fhevm.md&title=)
