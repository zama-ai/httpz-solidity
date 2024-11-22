# implementing access control with acl

This page provides detailed instructions and examples on how to use and implement the ACL (Access Control List) in fhEVM. For an overview of ACL concepts and their importance, refer to the [access control list (ACL) overview](../acl.md).

---

## controlling access: permanent and transient allowances

The ACL system allows you to define two types of permissions for accessing ciphertexts:

### permanent allowance
- **Function**: `TFHE.allow(ciphertext, address)`  
- **Purpose**: Grants persistent access to a ciphertext for a specific address.  
- **Storage**: Permissions are saved in a dedicated ACL contract, making them available across transactions.  

### transient allowance
- **Function**: `TFHE.allowTransient(ciphertext, address)`  
- **Purpose**: Grants temporary access for the duration of a single transaction.  
- **Storage**: Permissions are stored in transient storage to save gas costs.  
- **Use Case**: Ideal for passing encrypted values between functions or contracts during a transaction.

### syntactic sugar
- **Function**: `TFHE.allowThis(ciphertext)`  
- **Equivalent To**: `TFHE.allow(ciphertext, address(this))`  
- **Purpose**: Simplifies granting permanent access to the current contract for managing ciphertexts.

---

### Example: granting permissions in a multi-contract setup
```solidity
import "fhevm/lib/TFHE.sol";

contract SecretGiver {
  SecretStore public secretStore;

  constructor() {
    TFHE.setFHEVM(FHEVMConfig.defaultConfig());
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

---

## Automatic transient allowance

Some functions automatically grant transient allowances to the calling contract, simplifying workflow. These include:

- **Type Conversion**:  
  - `TFHE.asEuintXX()`, `TFHE.asEbool()`, `TFHE.asEaddress()`  
- **Random Value Generation**:  
  - `TFHE.randXX()`  
- **Computation Results**:  
  - `TFHE.add()`, `TFHE.select()`  

### example: random value generation
```solidity
function randomize() public {
  // Generate a random encrypted value with transient allowance
  euint64 random = TFHE.randEuint64();

  // Convert the transient allowance into a permanent one
  TFHE.allowThis(random);
}
```

---

## Security best practices

### Verifying sender access
When receiving ciphertexts as input, always verify that the sender is authorized to access them. Use the `TFHE.isSenderAllowed()` function to enforce this check.

#### Example: secure verification
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

---

By understanding how to grant and verify permissions, you can effectively manage access to encrypted data in your fhEVM smart contracts. For additional context, see the [ACL overview](../acl.md).