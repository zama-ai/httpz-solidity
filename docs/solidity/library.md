# Library

The TFHE library exposes functions for:
 - homomorphic operations involving TFHE ciphertexts
 - decrypting or reencrypting TFHE ciphertexts

Its goal is to provide a seamless developer experience for writing smart contracts that operate on confidential data.

It is under active development and some features are implemented, some are mockups and others are coming soon.

## Types

The TFHE library provides encrypted integer types and a type system that is checked both at compile time and at run time.

Encrypted integers behave as much as possible as Solidity's integer types. Currently, however, behaviour such as "revert on overflow" is not supported as this would leak some information about the encrypted value. Therefore, arithmetic on `euint` types is [unchecked](https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic), i.e. there is wrap-around on overlow.

Encrypted integers with overflow checking are coming soon to the THFE library. They will allow reversal in case of an overflow, but will
leak some information about the operands.

In terms of implementation in the backend, encrypted integers take the form of TFHE ciphertexts.
The TFHE library abstracts away that and, instead, exposes ciphertext handles to the smart contract developer.
The `euint` types are _wrappers_ over these handles.

The following TFHE data types are defined:

| type                  | supported       |
| --------------------- | ----------------|
| `ebool`               | yes (1)         |
| `euint8`              | yes             |
| `euint16`             | yes             |
| `euint32`             | yes             |
| `euint64`             | no, coming soon |
| `euint128`            | no              |
| `euint256`            | no              |
| `eint8`               | no, coming soon |
| `eint16`              | no, coming soon |
| `eint32`              | no, coming soon |
| `eint64`              | no, coming soon |
| `eint128`             | no              |
| `eint256`             | no              |

> **_NOTE 1:_** The `ebool` type is currently implemented as an `euint8`. A more optimized native boolean type will replace `euint8`.

## Operations

The TFHE library exposes the following operations involving TFHE ciphertexts:

| name                  | function name       | type         | supported            |
| --------------------- | ------------------- | ------------ | -------------------- |
| Add                   | `TFHE.add`          | Binary       | yes                  |
| Add w/ Overflow Check | `TFHE.safeAdd`      | Binary       | no, coming soon      |
| Sub                   | `TFHE.sub`          | Binary       | yes                  |
| Sub w/ Overflow Check | `TFHE.safeSub`      | Binary       | no, coming soon      |
| Mul                   | `TFHE.mul`          | Binary       | yes                  |
| Mul w/ Overflow Check | `TFHE.safeMul`      | Binary       | no, coming soon      |
| BitAnd                | `TFHE.and`          | Binary       | yes                  |
| BitOr                 | `TFHE.or`           | Binary       | yes                  |
| BitXor                | `TFHE.xor`          | Binary       | yes                  |
| Shift Right           | `TFHE.shr`          | Binary       | yes                  |
| Shift Left            | `TFHE.shl`          | Binary       | yes                  |
| Equal                 | `TFHE.eq`           | Binary       | yes                  |
| Not equal             | `TFHE.ne`           | Binary       | yes                  |
| Greater than or equal | `TFHE.ge`           | Binary       | yes                  |
| Greater than          | `TFHE.gt`           | Binary       | yes                  |
| Less than or equal    | `TFHE.le`           | Binary       | yes                  |
| Less than             | `TFHE.lt`           | Binary       | yes                  |
| Min                   | `TFHE.min`          | Binary       | yes                  |
| Max                   | `TFHE.max`          | Binary       | yes                  |
| Neg                   | `TFHE.neg`          | Unary        | yes                  |
| Not                   | `TFHE.not`          | Unary        | yes                  |
| Cmux                  | `TFHE.cmux`         | Ternary      | yes (1)              |
| Decrypt               | `TFHE.decrypt()`    | Decryption   | yes (2)              |
| Reencrypt             | `TFHE.reencrypt()`  | Reencryption | yes (2)              |
| Optimistic Require    | `TFHE.optReq()`     | Decryption   | yes (1)              |
| Random unsigned int   | `TFHE.randEuintX()` | Random       | mockup (3)           |
| Random signed int     | `TFHE.randEintX()`  | Random       | mockup coming soon   |

> **_NOTE 1:_**

> **_NOTE 2:_**

> **_NOTE 3:_**

More information about the supported operations can be found at the [TFHE-rs docs](https://docs.zama.ai/tfhe-rs/getting-started/operations#arithmetic-operations.).
