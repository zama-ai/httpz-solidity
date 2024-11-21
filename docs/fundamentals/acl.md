# **Access Control List (ACL)**

The Access Control List (ACL) system in fhEVM ensures that only authorized addresses can access or manipulate ciphertexts. This document outlines how ACLs work, their configuration options, and best practices for securing encrypted data in smart contracts.

---

## **How ACLs Work**

The ACL system controls who can access or manipulate specific ciphertexts stored on the blockchain. It supports two types of allowances:

1. **Permanent Allowance**:  
   - Configured using `TFHE.allow(ciphertext, address)`.  
   - Grants long-term access to the ciphertext for a specific address.  
   - Stored in a dedicated contract for persistent storage.

2. **Transient Allowance**:  
   - Configured using `TFHE.allowTransient(ciphertext, address)`.  
   - Grants access to the ciphertext only for the duration of the current transaction.  
   - Stored in transient storage, reducing gas costs.  
   - Ideal for temporary operations like passing ciphertexts to external functions.

**Syntactic Sugar**:  
- `TFHE.allowThis(ciphertext)` is shorthand for `TFHE.allow(ciphertext, address(this))`. It authorizes the current contract to reuse a ciphertext handle in future transactions.


## **Transient vs. Permanent Allowance**

| **Allowance Type**   | **Purpose**                                             | **Storage Type**            | **Use Case**                                                                 |
|-----------------------|---------------------------------------------------------|-----------------------------|-------------------------------------------------------------------------------|
| **Transient**         | Temporary access during a transaction.                  | [Transient storage](https://eips.ethereum.org/EIPS/eip-1153) (EIP-1153) | Calling external functions or computations with ciphertexts. Use when wanting to save on gas costs.                 |
| **Permanent**         | Long-term access across multiple transactions.          | Dedicated contract storage  | Persistent ciphertexts for contracts or users requiring ongoing access.       |

---


### Example: Function Interaction Using ACLs


Here’s an example illustrating how transient and permanent allowances work in a multi-contract setup:

```solidity
import "fhevm/lib/TFHE.sol";

contract SecretGiver {
  SecretStore public secretStore;

  constructor() {
    secretStore = new SecretStore();
  }

  function giveMySecret() public {
    // Create my secret - asEuint16 gives automatically transient allowance for the resulting handle (note: an onchain trivial encryption is not secret)
    euint16 mySecret = TFHE.asEuint16(42);

    // Allow temporarily the SecretStore contract to manipulate `mySecret`
    TFHE.allowTransient(mySecret, address(secretStore));

    // Call `secretStore` with `mySecret`
    secretStore.storeSecret(mySecret);
  }
}

contract SecretStore {
  euint16 public secretResult;

  function storeSecret(euint16 callerSecret) public {
    // Verify that the caller has also access to this ciphertext
    require(TFHE.isSenderAllowed(callerSecret), "The caller is not authorized to access this secret.");

    // do some FHE computation (result is automatically put in the ACL transient storage)
    euint16 computationResult = TFHE.add(callerSecret, 3);

    // then store the resulting ciphertext handle in the contract storage
    secretResult = computationResult;

    // Make the temporary allowance for this ciphertext permanent to let the contract able to reuse it at a later stage or request a decryption of it
    TFHE.allowThis(secretResult); // this is strictly equivalent to `TFHE.allow(secretResult, address(this));``
  }
}
```

## **Automatic Transient Allowance**

Certain functions automatically grant transient allowances to the calling contract, eliminating the need for manual configuration. These include:

- **Type Conversion Functions**:  
  - `TFHE.asEuintXX()`, `TFHE.asEaddress()`, `TFHE.asEbool()`.
- **Random Number Generation**:  
  - `TFHE.randXX()`.
- **Computation Results**:  
  - Operations such as `TFHE.add()`, `TFHE.select()`.

### Example: Random Value Generation with Transient Allowance

```solidity
function randomize() public {
  // Generate a random encrypted value with transient allowance
  euint64 random = TFHE.randEuint64();

  // Convert the transient allowance into a permanent one
  TFHE.allowThis(random);
}
```

## Security Best Practices: Verifying Access with `isSenderAllowed()`

When a function receives a ciphertext (such as `ebool`, `euint8`, `eaddress`, ...), it needs to verify that the sender also has access to this ciphertext. This verification is crucial for security.

Without this check, a contract could send any ciphertext authorized for the contract and potentially exploit the function to retrieve the value. For example, an attacker could transfer someone's balance as an encrypted amount.

If the function does not include `require(TFHE.isSenderAllowed(encryptedAmount))`, an attacker who doesn't have access to this balance could determine the value by transferring the balance between two well-funded accounts.

### Example: Secure Verification
```solidity
function transfer(address to, euint64 encryptedAmount, bytes calldata inputProof) public {
  // Ensure the sender is authorized to access the encrypted amount
  require(TFHE.isSenderAllowed(encryptedAmount), "Unauthorized access to encrypted amount.");

  // Proceed with further logic
  euint64 amount = TFHE.asEuint64(encryptedAmount);
  ...
}
```

## ACL for reencryption

If a ciphertext must be reencrypted by a user, then explicit access must be granted to them. If this authorization is not given, the user will be unable to request a reencryption of this ciphertext.

Due to the reencryption mechanism, a user signs a public key associated with a specific contract; therefore, the ciphertext also needs to be allowed for the contract.


### Example: Secure Transfer in Encrypted ERC-20
```solidity
function transfer(address to, euint64 encryptedAmount) public {
  require(TFHE.isSenderAllowed(encryptedAmount), "The caller is not authorized to access this encrypted amount.");
  euint64 amount = TFHE.asEuint64(encryptedAmount);
  ebool canTransfer = TFHE.le(amount, balances[msg.sender]);

  euint64 newBalanceTo = TFHE.add(balances[to], TFHE.select(canTransfer, amount, TFHE.asEuint64(0)));
  balances[to] = newBalanceTo;
  // Allow this new balance for both the contract and the owner.
  TFHE.allowThis(newBalanceTo);
  TFHE.allow(newBalanceTo, to);

  euint64 newBalanceFrom = TFHE.sub(balances[from], TFHE.select(canTransfer, amount, TFHE.asEuint64(0)));
  balances[from] = newBalanceFrom;
  // Allow this new balance for both the contract and the owner.
  TFHE.allowThis(newBalanceFrom);
  TFHE.allow(newBalanceFrom, from);
}
```
