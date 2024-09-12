// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.24;

import "./ACLAddress.sol";
import "./FHEPaymentAddress.sol";
import "./KMSVerifierAddress.sol";
import "./TFHEExecutorAddress.sol";

library FHEVMConfig {
    struct FHEVMConfigStruct {
        address ACLAddress;
        address TFHEExecutorAddress;
        address FHEPaymentAddress;
        address KMSVerifierAddress;
    }

    /// @dev Function to return an immutable struct
    function defaultConfig() internal pure returns (FHEVMConfigStruct memory) {
        return
            FHEVMConfigStruct({
                ACLAddress: aclAdd,
                TFHEExecutorAddress: tfheExecutorAdd,
                FHEPaymentAddress: fhePaymentAdd,
                KMSVerifierAddress: kmsVerifierAdd
            });
    }
}
