# Error handling

This document explains how to do error handling.

If a condition is not satisfied, the transaction will not be reverted, which can be challenging to communicate issues to users. 

To address this, a recommended approach is to implement an error handler that stores the latest error information for all wallets:

```solidity
struct LastError {
  euint8 error;
  uint timestamp;
}

euint8 internal NO_ERROR;
euint8 internal NOT_ENOUGH_FUND;

constructor() {
  NO_ERROR = TFHE.asEuint8(0);
  NOT_ENOUGH_FUND = TFHE.asEuint8(1);
}

function setLastError(euint8 error, address addr) private {
  _lastErrors[addr] = LastError(error, block.timestamp);
  emit ErrorChanged(addr);
}

function _transfer(address from, address to, euint32 amount) internal {
  // Make sure the sender has enough tokens.
  ebool canTransfer = TFHE.le(amount, balances[from]);
  setLastError(TFHE.select(canTransfer, NO_ERROR, NOT_ENOUGH_FUND), msg.sender);

  // Add to the balance of `to` and subract from the balance of `from`.
  balances[to] = TFHE.add(balances[to], TFHE.select(canTransfer, amount, TFHE.asEuint32(0)));
  TFHE.allowThis(balances[to]);
  TFHE.allow(balances[to], to);

  balances[from] = TFHE.sub(balances[from], TFHE.select(canTransfer, amount, TFHE.asEuint32(0)));
  TFHE.allowThis(balances[from]);
  TFHE.allow(balances[from], from);
}
```
