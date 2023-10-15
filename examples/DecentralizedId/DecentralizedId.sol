// SPDX-License-Identifier: BSD-3-Clause-Clear

// Owner = ONU
// Issuer par pays
// Did associé à un issuer

pragma solidity 0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "../../abstracts/EIP712WithModifier.sol";

import "../../lib/TFHE.sol";

contract DecentralizedId is EIP712WithModifier, Ownable {
    // A mapping from did to an identity.
    mapping(uint8 => address) issuers;

    // A mapping from did to an identity.
    mapping(address => Identity) internal identities;

    struct Identity {
        string did;
        euint8 country;
        mapping(string => euint32) identifiers;
    }

    mapping(address => mapping(address => mapping(string => bool))) permissions; // user => contracts => identifiers[]

    event NewId(address owner, string did);
    event RemoveId(address wallet);

    constructor() EIP712WithModifier("Authorization token", "1") {}

    function addId(address owner, string calldata did) public onlyOwner {
        require(bytes(identities[owner].did).length == 0, "This did already exists");
        Identity storage newIdentity = identities[owner];
        newIdentity.did = did;

        emit NewId(owner, did);
    }

    function removeId(address wallet) public onlyOwner {
        require(bytes(identities[wallet].did).length > 0, "This did doesn't exist");
        delete identities[wallet];

        emit RemoveId(wallet);
    }

    function getDid(address wallet) public view returns (string memory) {
        return identities[wallet].did;
    }

    function changeOwner(address currentOwner, address newOwner) public onlyOwner {
        require(bytes(identities[newOwner].did).length == 0, "Address already owns a wallet");
        Identity storage ident = identities[currentOwner];
        Identity storage newIdent = identities[newOwner];
        newIdent = ident;
        delete identities[currentOwner];
    }

    function setIdentifier(address wallet, string calldata identifier, bytes calldata encryptedValue) public {
        euint32 value = TFHE.asEuint32(encryptedValue);
        setIdentifier(wallet, identifier, value);
    }

    function setIdentifier(address wallet, string calldata identifier, euint32 value) public onlyOwner {
        identities[wallet].identifiers[identifier] = value;
    }

    function reencryptIdentifier(
        address wallet,
        string calldata identifier,
        bytes32 publicKey,
        bytes calldata signature
    ) public view onlySignedPublicKey(publicKey, signature) returns (bytes memory) {
        euint32 ident = _getIdentifier(wallet, identifier);
        require(TFHE.isInitialized(ident), "This identifier is unknown");

        return TFHE.reencrypt(ident, publicKey, 0);
    }

    function getIdentifier(address wallet, string calldata identifier) public view returns (euint32) {
        require(permissions[wallet][msg.sender][identifier], "You don't have the permission.");
        return _getIdentifier(wallet, identifier);
    }

    function _getIdentifier(address wallet, string calldata identifier) internal view returns (euint32) {
        require(bytes(identities[wallet].did).length > 0, "DID doesn't exist");
        return identities[wallet].identifiers[identifier];
    }
}
