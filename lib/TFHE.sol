// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity >=0.8.13 <0.9.0;

import "./Common.sol";
import "./Impl.sol";

library TFHE {
    function add(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.add(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function add(uint256 a, euint8 b) internal view returns (euint8) {
        return add(asEuint8(a), b);
    }

    function add(euint8 a, uint256 b) internal view returns (euint8) {
        return add(a, asEuint8(b));
    }

    function sub(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.sub(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function sub(uint256 a, euint8 b) internal view returns (euint8) {
        return sub(asEuint8(a), b);
    }

    function sub(euint8 a, uint256 b) internal view returns (euint8) {
        return sub(a, asEuint8(b));
    }

    function mul(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.mul(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function mul(uint256 a, euint8 b) internal view returns (euint8) {
        return mul(asEuint8(a), b);
    }

    function mul(euint8 a, uint256 b) internal view returns (euint8) {
        return mul(a, asEuint8(b));
    }

    function and(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.and(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function and(uint256 a, euint8 b) internal view returns (euint8) {
        return and(asEuint8(a), b);
    }

    function and(euint8 a, uint256 b) internal view returns (euint8) {
        return and(a, asEuint8(b));
    }

    function or(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.or(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function or(uint256 a, euint8 b) internal view returns (euint8) {
        return or(asEuint8(a), b);
    }

    function or(euint8 a, uint256 b) internal view returns (euint8) {
        return or(a, asEuint8(b));
    }

    function xor(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.xor(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function xor(uint256 a, euint8 b) internal view returns (euint8) {
        return xor(asEuint8(a), b);
    }

    function xor(euint8 a, uint256 b) internal view returns (euint8) {
        return xor(a, asEuint8(b));
    }

    function eq(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.eq(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function eq(uint256 a, euint8 b) internal view returns (euint8) {
        return eq(asEuint8(a), b);
    }

    function eq(euint8 a, uint256 b) internal view returns (euint8) {
        return eq(a, asEuint8(b));
    }

    function ge(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.ge(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function ge(uint256 a, euint8 b) internal view returns (euint8) {
        return ge(asEuint8(a), b);
    }

    function ge(euint8 a, uint256 b) internal view returns (euint8) {
        return ge(a, asEuint8(b));
    }

    function gt(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.gt(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function gt(uint256 a, euint8 b) internal view returns (euint8) {
        return gt(asEuint8(a), b);
    }

    function gt(euint8 a, uint256 b) internal view returns (euint8) {
        return gt(a, asEuint8(b));
    }

    function lte(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.lte(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function lte(uint256 a, euint8 b) internal view returns (euint8) {
        return lte(asEuint8(a), b);
    }

    function lte(euint8 a, uint256 b) internal view returns (euint8) {
        return lte(a, asEuint8(b));
    }

    function lt(euint8 a, euint8 b) internal view returns (euint8) {
        return euint8.wrap(Impl.lt(euint8.unwrap(a), euint8.unwrap(b)));
    }

    function lt(uint256 a, euint8 b) internal view returns (euint8) {
        return lt(asEuint8(a), b);
    }

    function lt(euint8 a, uint256 b) internal view returns (euint8) {
        return lt(a, asEuint8(b));
    }

    function add(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.add(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function add(uint256 a, euint16 b) internal view returns (euint16) {
        return add(asEuint16(a), b);
    }

    function add(euint16 a, uint256 b) internal view returns (euint16) {
        return add(a, asEuint16(b));
    }

    function sub(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.sub(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function sub(uint256 a, euint16 b) internal view returns (euint16) {
        return sub(asEuint16(a), b);
    }

    function sub(euint16 a, uint256 b) internal view returns (euint16) {
        return sub(a, asEuint16(b));
    }

    function mul(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.mul(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function mul(uint256 a, euint16 b) internal view returns (euint16) {
        return mul(asEuint16(a), b);
    }

    function mul(euint16 a, uint256 b) internal view returns (euint16) {
        return mul(a, asEuint16(b));
    }

    function and(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.and(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function and(uint256 a, euint16 b) internal view returns (euint16) {
        return and(asEuint16(a), b);
    }

    function and(euint16 a, uint256 b) internal view returns (euint16) {
        return and(a, asEuint16(b));
    }

    function or(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.or(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function or(uint256 a, euint16 b) internal view returns (euint16) {
        return or(asEuint16(a), b);
    }

    function or(euint16 a, uint256 b) internal view returns (euint16) {
        return or(a, asEuint16(b));
    }

    function xor(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.xor(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function xor(uint256 a, euint16 b) internal view returns (euint16) {
        return xor(asEuint16(a), b);
    }

    function xor(euint16 a, uint256 b) internal view returns (euint16) {
        return xor(a, asEuint16(b));
    }

    function eq(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.eq(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function eq(uint256 a, euint16 b) internal view returns (euint16) {
        return eq(asEuint16(a), b);
    }

    function eq(euint16 a, uint256 b) internal view returns (euint16) {
        return eq(a, asEuint16(b));
    }

    function ge(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.ge(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function ge(uint256 a, euint16 b) internal view returns (euint16) {
        return ge(asEuint16(a), b);
    }

    function ge(euint16 a, uint256 b) internal view returns (euint16) {
        return ge(a, asEuint16(b));
    }

    function gt(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.gt(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function gt(uint256 a, euint16 b) internal view returns (euint16) {
        return gt(asEuint16(a), b);
    }

    function gt(euint16 a, uint256 b) internal view returns (euint16) {
        return gt(a, asEuint16(b));
    }

    function lte(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.lte(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function lte(uint256 a, euint16 b) internal view returns (euint16) {
        return lte(asEuint16(a), b);
    }

    function lte(euint16 a, uint256 b) internal view returns (euint16) {
        return lte(a, asEuint16(b));
    }

    function lt(euint16 a, euint16 b) internal view returns (euint16) {
        return euint16.wrap(Impl.lt(euint16.unwrap(a), euint16.unwrap(b)));
    }

    function lt(uint256 a, euint16 b) internal view returns (euint16) {
        return lt(asEuint16(a), b);
    }

    function lt(euint16 a, uint256 b) internal view returns (euint16) {
        return lt(a, asEuint16(b));
    }

    function add(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.add(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function add(uint256 a, euint32 b) internal view returns (euint32) {
        return add(asEuint32(a), b);
    }

    function add(euint32 a, uint256 b) internal view returns (euint32) {
        return add(a, asEuint32(b));
    }

    function sub(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.sub(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function sub(uint256 a, euint32 b) internal view returns (euint32) {
        return sub(asEuint32(a), b);
    }

    function sub(euint32 a, uint256 b) internal view returns (euint32) {
        return sub(a, asEuint32(b));
    }

    function mul(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.mul(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function mul(uint256 a, euint32 b) internal view returns (euint32) {
        return mul(asEuint32(a), b);
    }

    function mul(euint32 a, uint256 b) internal view returns (euint32) {
        return mul(a, asEuint32(b));
    }

    function and(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.and(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function and(uint256 a, euint32 b) internal view returns (euint32) {
        return and(asEuint32(a), b);
    }

    function and(euint32 a, uint256 b) internal view returns (euint32) {
        return and(a, asEuint32(b));
    }

    function or(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.or(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function or(uint256 a, euint32 b) internal view returns (euint32) {
        return or(asEuint32(a), b);
    }

    function or(euint32 a, uint256 b) internal view returns (euint32) {
        return or(a, asEuint32(b));
    }

    function xor(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.xor(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function xor(uint256 a, euint32 b) internal view returns (euint32) {
        return xor(asEuint32(a), b);
    }

    function xor(euint32 a, uint256 b) internal view returns (euint32) {
        return xor(a, asEuint32(b));
    }

    function eq(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.eq(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function eq(uint256 a, euint32 b) internal view returns (euint32) {
        return eq(asEuint32(a), b);
    }

    function eq(euint32 a, uint256 b) internal view returns (euint32) {
        return eq(a, asEuint32(b));
    }

    function ge(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.ge(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function ge(uint256 a, euint32 b) internal view returns (euint32) {
        return ge(asEuint32(a), b);
    }

    function ge(euint32 a, uint256 b) internal view returns (euint32) {
        return ge(a, asEuint32(b));
    }

    function gt(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.gt(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function gt(uint256 a, euint32 b) internal view returns (euint32) {
        return gt(asEuint32(a), b);
    }

    function gt(euint32 a, uint256 b) internal view returns (euint32) {
        return gt(a, asEuint32(b));
    }

    function lte(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.lte(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function lte(uint256 a, euint32 b) internal view returns (euint32) {
        return lte(asEuint32(a), b);
    }

    function lte(euint32 a, uint256 b) internal view returns (euint32) {
        return lte(a, asEuint32(b));
    }

    function lt(euint32 a, euint32 b) internal view returns (euint32) {
        return euint32.wrap(Impl.lt(euint32.unwrap(a), euint32.unwrap(b)));
    }

    function lt(uint256 a, euint32 b) internal view returns (euint32) {
        return lt(asEuint32(a), b);
    }

    function lt(euint32 a, uint256 b) internal view returns (euint32) {
        return lt(a, asEuint32(b));
    }

    function cmux(
        euint8 control,
        euint8 a,
        euint8 b
    ) internal view returns (euint8) {
        return
            euint8.wrap(
                Impl.cmux(
                    euint8.unwrap(control),
                    euint8.unwrap(a),
                    euint8.unwrap(b)
                )
            );
    }

    function cmux(
        euint8 control,
        euint16 a,
        euint16 b
    ) internal view returns (euint16) {
        return
            euint16.wrap(
                Impl.cmux(
                    euint8.unwrap(control),
                    euint16.unwrap(a),
                    euint16.unwrap(b)
                )
            );
    }

    function cmux(
        euint8 control,
        euint32 a,
        euint32 b
    ) internal view returns (euint32) {
        return
            euint32.wrap(
                Impl.cmux(
                    euint8.unwrap(control),
                    euint32.unwrap(a),
                    euint32.unwrap(b)
                )
            );
    }

    function asEuint8(euint16 ciphertext) internal view returns (euint8) {
        return
            euint8.wrap(Impl.cast(euint16.unwrap(ciphertext), Common.euint8_t));
    }

    function asEuint8(euint32 ciphertext) internal view returns (euint8) {
        return
            euint8.wrap(Impl.cast(euint32.unwrap(ciphertext), Common.euint8_t));
    }

    function asEuint16(euint8 ciphertext) internal view returns (euint16) {
        return
            euint16.wrap(
                Impl.cast(euint8.unwrap(ciphertext), Common.euint16_t)
            );
    }

    function asEuint16(euint32 ciphertext) internal view returns (euint16) {
        return
            euint16.wrap(
                Impl.cast(euint32.unwrap(ciphertext), Common.euint16_t)
            );
    }

    function asEuint32(euint8 ciphertext) internal view returns (euint32) {
        return
            euint32.wrap(
                Impl.cast(euint8.unwrap(ciphertext), Common.euint32_t)
            );
    }

    function asEuint32(euint16 ciphertext) internal view returns (euint32) {
        return
            euint32.wrap(
                Impl.cast(euint16.unwrap(ciphertext), Common.euint32_t)
            );
    }

    function asEuint8(bytes memory ciphertext) internal view returns (euint8) {
        return euint8.wrap(Impl.verify(ciphertext, Common.euint8_t));
    }

    function asEuint8(uint256 value) internal view returns (euint8) {
        return euint8.wrap(Impl.trivialEncrypt(value, Common.euint8_t));
    }

    function reencrypt(
        euint8 ciphertext,
        bytes32 publicKey
    ) internal view returns (bytes memory reencrypted) {
        return Impl.reencrypt(euint8.unwrap(ciphertext), publicKey);
    }

    function requireCt(euint8 ciphertext) internal view {
        Impl.requireCt(euint8.unwrap(ciphertext));
    }

    function optimisticRequireCt(euint8 ciphertext) internal view {
        Impl.optimisticRequireCt(euint8.unwrap(ciphertext));
    }

    function asEuint16(
        bytes memory ciphertext
    ) internal view returns (euint16) {
        return euint16.wrap(Impl.verify(ciphertext, Common.euint16_t));
    }

    function asEuint16(uint256 value) internal view returns (euint16) {
        return euint16.wrap(Impl.trivialEncrypt(value, Common.euint16_t));
    }

    function reencrypt(
        euint16 ciphertext,
        bytes32 publicKey
    ) internal view returns (bytes memory reencrypted) {
        return Impl.reencrypt(euint16.unwrap(ciphertext), publicKey);
    }

    function requireCt(euint16 ciphertext) internal view {
        Impl.requireCt(euint16.unwrap(ciphertext));
    }

    function optimisticRequireCt(euint16 ciphertext) internal view {
        Impl.optimisticRequireCt(euint16.unwrap(ciphertext));
    }

    function asEuint32(
        bytes memory ciphertext
    ) internal view returns (euint32) {
        return euint32.wrap(Impl.verify(ciphertext, Common.euint32_t));
    }

    function asEuint32(uint256 value) internal view returns (euint32) {
        return euint32.wrap(Impl.trivialEncrypt(value, Common.euint32_t));
    }

    function reencrypt(
        euint32 ciphertext,
        bytes32 publicKey
    ) internal view returns (bytes memory reencrypted) {
        return Impl.reencrypt(euint32.unwrap(ciphertext), publicKey);
    }

    function requireCt(euint32 ciphertext) internal view {
        Impl.requireCt(euint32.unwrap(ciphertext));
    }

    function optimisticRequireCt(euint32 ciphertext) internal view {
        Impl.optimisticRequireCt(euint32.unwrap(ciphertext));
    }

    // Returns the network public FHE key.
    function fhePubKey() internal view returns (bytes memory) {
        return Impl.fhePubKey();
    }
}
