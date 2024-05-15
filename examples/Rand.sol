// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity ^0.8.20;

import "../lib/TFHE.sol";

contract Rand {
    euint8 value8;
    euint16 value16;
    euint32 value32;
    euint64 value64;
    uint8 public value8Decrypted;
    uint16 public value16Decrypted;
    uint32 public value32Decrypted;
    uint64 public value64Decrypted;

    function generate8() public {
        value8 = TFHE.randEuint8();
        TFHE.allow(value8, address(this));
    }

    function generate8UpperBound(uint8 upperBound) public {
        value8 = TFHE.randEuint8(upperBound);
        TFHE.allow(value8, address(this));
    }

    function generate16() public {
        value16 = TFHE.randEuint16();
        TFHE.allow(value16, address(this));
    }

    function generate16UpperBound(uint16 upperBound) public {
        value16 = TFHE.randEuint16(upperBound);
        TFHE.allow(value16, address(this));
    }

    function generate32() public {
        value32 = TFHE.randEuint32();
        TFHE.allow(value32, address(this));
    }

    function generate32UpperBound(uint32 upperBound) public {
        value32 = TFHE.randEuint32(upperBound);
        TFHE.allow(value32, address(this));
    }

    function generate64() public {
        value64 = TFHE.randEuint64();
        TFHE.allow(value64, address(this));
    }

    function generate64UpperBound(uint32 upperBound) public {
        value64 = TFHE.randEuint64(upperBound);
        TFHE.allow(value64, address(this));
    }

    function decrypt8() public view returns (uint8) {
        return TFHE.decrypt(value8);
    }

    function decrypt16() public view returns (uint16) {
        return TFHE.decrypt(value16);
    }

    function decrypt32() public view returns (uint32) {
        return TFHE.decrypt(value32);
    }

    function decrypt64() public view returns (uint64) {
        return TFHE.decrypt(value64);
    }

    function decryptAndStore8() public {
        value8Decrypted = TFHE.decrypt(value8);
    }

    function decryptAndStore16() public {
        value16Decrypted = TFHE.decrypt(value16);
    }

    function decryptAndStore32() public {
        value32Decrypted = TFHE.decrypt(value32);
    }

    function decryptAndStore64() public {
        value64Decrypted = TFHE.decrypt(value64);
    }
}
