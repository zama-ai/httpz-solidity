# Conditional logic in FHE

This document explains how to implement conditional logic (if/else branching) when working with encrypted values in fhEVM.

When you perform [comparison operations](../../references/functions.md#comparison-operation-eq-ne-ge-gt-le-lt) in fhEVM, the result is an encrypted boolean `ebool`, which does not support typical boolean operations.

## Condition with encrypted boolean

fhEVM provides a method which acts as a ternary operator on encrypted integers. This method is called [select](../../references/functions.md#multiplexer-operator-select).

```solidity
function bid(einput encryptedValue, bytes calldata inputProof) public onlyBeforeEnd {
  euint64 bid = TFHE.asEuint64(encryptedValue, inputProof);
  ebool isAbove = TFHE.lt(highestBid, bid);

  // Replace highest bid
  highestBid = TFHE.select(isAbove, bid, highestBid);
  TFHE.allowThis(highestBid);
}
```

Keep in mind that each time we assign a value using `TFHE.select`, the value changes, even if the plaintext value remains the same.
