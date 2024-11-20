# Generate Random Encrypted Numbers

This document explains how to generate cryptographically secure random encrypted numbers fully on-chain.

{% hint style="info" %}
Random number generation must be performed during transactions, as it requires the pseudo-random number generator (PRNG) state to be mutated on-chain. Therefore, it cannot be executed using the `eth_call` RPC method.
{% endhint %}

## Basic Usage

You can generate random encrypted numbers of various bit sizes:

```solidity
// Generate random encrypted numbers
ebool rb = TFHE.randEbool();      // Random boolean
euint4 r4 = TFHE.randEuint4();    // Random 4-bit number
euint8 r8 = TFHE.randEuint8();    // Random 8-bit number
euint16 r16 = TFHE.randEuint16(); // Random 16-bit number
euint32 r32 = TFHE.randEuint32(); // Random 32-bit number
euint64 r64 = TFHE.randEuint64(); // Random 64-bit number
euint128 r128 = TFHE.randEuint128(); // Random 128-bit number
euint256 r256 = TFHE.randEuint256(); // Random 256-bit number
```

## Bounded Random Numbers

You can also generate random numbers within a specific range by providing an upper bound (exclusive):

```solidity
// Generate random numbers with upper bounds
euint8 r8 = TFHE.randEuint8(100);     // Random number between 0-99
euint16 r16 = TFHE.randEuint16(1000); // Random number between 0-999
euint32 r32 = TFHE.randEuint32(1000000); // Random number between 0-999999
```

## Random Bytes

For larger random values, you can generate random encrypted bytes:

```solidity
// Generate random encrypted bytes
ebytes64 rb64 = TFHE.randEbytes64();   // 512 bits
ebytes128 rb128 = TFHE.randEbytes128(); // 1024 bits
ebytes256 rb256 = TFHE.randEbytes256(); // 2048 bits
```

## Security Considerations

- Random numbers generated are cryptographically secure and encrypted
- Values remain encrypted until explicitly decrypted
- Each call to a random generation function will consume gas

