# Build with ConfidentialERC20 tutorial

This tutorial will guide you through building a confidential ERC20 token using fhEVM. You'll learn how to create a token where balances and transfers are encrypted while maintaining ERC20 compatibility.

## Prerequisites

Before starting this tutorial, make sure you have:

1. Set up your development environment following the [Quick Start Guide](../getting_started/ethereum.md)
2. Basic understanding of [ERC20 tokens](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/)
3. Familiarity with [encrypted types and operations](../fundamentals/types.md)

## Understanding Confidential ERC20

A confidential ERC20 token differs from a standard ERC20 in several ways:

- Token balances are encrypted and private
- Transfer amounts are encrypted
- Total supply may be encrypted or public
- Standard ERC20 events are emitted but with encrypted values

## Implementation

Let's build a basic confidential ERC20 token step by step.

### 1. Basic Contract Structure
