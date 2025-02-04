// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHEVMConfigStruct, TFHE} from "../lib/TFHE.sol";
import "./FHEVMConfig.sol";
import "./GatewayConfig.sol";
import "../gateway/GatewayCaller.sol";
import "hardhat/console.sol";

/// @title EncryptedCounter3
/// @notice A contract that maintains an encrypted counter and is meant for demonstrating how decryption works
/// @dev Uses TFHE library for fully homomorphic encryption operations and Gateway for decryption
/// @custom:experimental This contract is experimental and uses FHE technology with decryption capabilities
contract EncryptedCounter3 is GatewayCaller {
    /// @dev Decrypted state variable
    euint8 internal counter;
    uint8 public decryptedCounter;
    euint8 internal immutable CONST_ONE;

    constructor(
        address ACLAddress,
        address TFHEExecutorAddress,
        address FHEPaymentAddress,
        address KMSVerifierAddress,
        address GatewayAddress
    ) {
        TFHE.setFHEVM(
            FHEVMConfigStruct({
                ACLAddress: ACLAddress,
                TFHEExecutorAddress: TFHEExecutorAddress,
                FHEPaymentAddress: FHEPaymentAddress,
                KMSVerifierAddress: KMSVerifierAddress
            })
        );
        Gateway.setGateway(GatewayAddress);

        // Initialize counter with an encrypted zero value
        counter = TFHE.asEuint8(0);
        TFHE.allowThis(counter);
        // Save on gas by computing the constant here
        CONST_ONE = TFHE.asEuint8(1);
        TFHE.allowThis(CONST_ONE);
    }

    function increment() public {
        // Perform encrypted addition to increment the counter
        counter = TFHE.add(counter, CONST_ONE);
        TFHE.allowThis(counter);
    }

    function incrementBy(einput amount, bytes calldata inputProof) public {
        // Convert input to euint8 and add to counter
        console.log("increment by");
        euint8 incrementAmount = TFHE.asEuint8(amount, inputProof);
        counter = TFHE.add(counter, incrementAmount);
        TFHE.allowThis(counter);
    }

    /// @notice Request decryption of the counter value
    function requestDecryptCounter() public {
        uint256[] memory cts = new uint256[](1);
        cts[0] = Gateway.toUint256(counter);
        Gateway.requestDecryption(cts, this.callbackCounter.selector, 0, block.timestamp + 100, false);
    }

    /// @notice Callback function for counter decryption
    /// @param decryptedInput The decrypted counter value
    /// @return The decrypted value
    function callbackCounter(uint256, uint8 decryptedInput) public onlyGateway returns (uint8) {
        decryptedCounter = decryptedInput;
        return decryptedInput;
    }

    /// @notice Get the decrypted counter value
    /// @return The decrypted counter value
    function getDecryptedCounter() public view returns (uint8) {
        return decryptedCounter;
    }
}
