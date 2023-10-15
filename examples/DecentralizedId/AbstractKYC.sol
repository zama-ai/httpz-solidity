// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity 0.8.19;

import "../../abstracts/EIP712WithModifier.sol";
import "./DecentralizedId.sol";

abstract contract AbstractKYC is EIP712WithModifier {
    DecentralizedId didContract;

    constructor(DecentralizedId _didContract) EIP712WithModifier("Authorization token", "1") {
        didContract = _didContract;
    }

    function balanceOf(
        address wallet,
        bytes32 publicKey,
        bytes calldata signature
    ) public view onlySignedPublicKey(publicKey, signature) returns (bytes memory) {
        address didOwner = didContract.owner();
        require(didOwner == msg.sender);
        string memory did = didContract.getDid(wallet);
        require(bytes(did).length != 0, "The user is not a did user");

        return TFHE.reencrypt(balances[wallet], publicKey, 0);
    }

    // Transfers an encrypted amount.
    function _transfer(address from, address to, euint32 _amount) internal {
        require(TFHE.decrypt(TFHE.le(amount, balances[from])));

        Identity fromDid = didContract.getDid(from);
        Identity toDid = didContract.getDid(to);
        require(bytes(fromDid.did).length > 0 && bytes(toDid.did).length > 0);
        ebool sameCountry = TFHE.eq(fromDid.country, toDid.country);
        ebool amountAbove10k = TFHE.le(_amount, 10000);

        euint32 amount = TFHE.cmux(sameCountry, _amount, TFHE.cmux(amountAbove10k, 0, _amount));

        // Add to the balance of `to` and subract from the balance of `from`.
        balances[to] = balances[to] + amount;
        balances[from] = balances[from] - amount;
    }
}
