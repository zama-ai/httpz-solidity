# Operations on encrypted types

This document outlines the operations supported on encrypted types in the `TFHE` library, enabling arithmetic, bitwise, comparison, and more on Fully Homomorphic Encryption (FHE) ciphertexts.

## Arithmetic operations
The following arithmetic operations are supported for encrypted integers (`euintX`):

| Name                    | Function name       | Symbol | Type    |
| ----------------------- | ------------------- | ------ | ------- |
| Add                     | `TFHE.add`          | `+`    | Binary  |
| Subtract                | `TFHE.sub`          | `-`    | Binary  |
| Multiply                | `TFHE.mul`          | `*`    | Binary  |
| Divide (plaintext divisor) | `TFHE.div`          |        | Binary  |
| Reminder (plaintext divisor) | `TFHE.rem`          |        | Binary  |
| Negation                     | `TFHE.neg`          | `-`    | Unary   |
| Min                     | `TFHE.min`          |        | Binary  |
| Max                     | `TFHE.max`          |        | Binary  |

> **Note**: Division (TFHE.div) and remainder (TFHE.rem) operations are currently supported only with plaintext divisors.

## Bitwise operations

The TFHE library also supports bitwise operations, including shifts and rotations:

| Name                    | Function name       | Symbol | Type    |
| ----------------------- | ------------------- | ------ | ------- |
| Bitwise AND             | `TFHE.and`          | `&`    | Binary  |
| Bitwise OR              | `TFHE.or`           | `\|`   | Binary  |
| Bitwise XOR             | `TFHE.xor`          | `^`    | Binary  |
| Bitwise NOT             | `TFHE.not`          | `~`    | Unary   |
| Shift Right             | `TFHE.shr`          |        | Binary  |
| Shift Left              | `TFHE.shl`          |        | Binary  |
| Rotate Right            | `TFHE.rotr`         |        | Binary  |
| Rotate Left             | `TFHE.rotl`         |        | Binary  |

{% hint style="info" %}
 The shift operators `TFHE.shr` and `TFHE.shl` can take any encrypted type `euintX` as a first operand and either a `uint8`or a `euint8` as a second operand, however the second operand will always be computed modulo the number of bits of the first operand. For example, `TFHE.shr(euint64 x, 70)` is equivalent to `TFHE.shr(euint64 x, 6)` because `70 % 64 = 6`. This differs from the classical shift operators in Solidity, where there is no intermediate modulo operation, so for instance any `uint64` shifted right via `>>` would give a null result.
 {% endhinr %}

## Comparison operations
Encrypted integers can be compared using the following functions:
| Name                    | Function name       | Symbol | Type    |
| ----------------------- | ------------------- | ------ | ------- |
| Equal                   | `TFHE.eq`           |        | Binary  |
| Not equal               | `TFHE.ne`           |        | Binary  |
| Greater than or equal   | `TFHE.ge`           |        | Binary  |
| Greater than            | `TFHE.gt`           |        | Binary  |
| Less than or equal      | `TFHE.le`           |        | Binary  |
| Less than               | `TFHE.lt`           |        | Binary  |

## Ternary operation 

The `TFHE.select` function is a ternary operation that selects one of two encrypted values based on an encrypted condition:

| Name                    | Function name       | Symbol | Type    |
| ----------------------- | ------------------- | ------ | ------- |
| Select                  | `TFHE.select`       |        | Ternary |

## Random operations

You can generate cryptographically secure random numbers fully on-chain:

| **Name**               | **Function Name**       | **Symbol** | **Type**  |
|-------------------------|-------------------------|------------|-----------|
| Random Unsigned Integer | `TFHE.randEuintX()`    |            | Random    |

For more details, refer to the [Random Encrypted Numbers](../../guides/random.md) document.

## Overload operators

The `TFHE` library supports operator overloading for encrypted integers (e.g., `+`, `-`, `*`, `&`) using the Solidity [`using for`](https://docs.soliditylang.org/en/v0.8.22/contracts.html#using-for) syntax. These overloaded operators currently perform unchecked operations, meaning they do not include overflow checks.

> **Example**:  
> Overloaded operators make code more concise:
```solidity
euint64 a = TFHE.asEuint64(42);
euint64 b = TFHE.asEuint64(58);
euint64 sum = a + b; // Calls TFHE.add under the hood
```


## Additional Resources

- For detailed API specifications, visit the [fhEVM API Documentation](../../references/functions.md).  
- Check our [Roadmap](../../developer/roadmap.md) for upcoming features or submit a feature request on [Discord](https://discord.com/invite/fhe-org).  
- Join the discussion on the [Community Forum](https://community.zama.ai/c/fhevm/15).

---

{% hint style="success" %}
**Zama 5-Question Developer Survey**

We want to hear from you! Take 1 minute to share your thoughts and helping us enhance our documentation and libraries. **👉** [**Click here**](https://www.zama.ai/developer-survey) to participate.
{% endhint %}