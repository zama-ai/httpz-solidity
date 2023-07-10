// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.20;

import "../lib/TFHE.sol";

contract Trivial {
    // euint32 and;
    // euint32 or;
    // euint32 xor;
    // euint32 eq;
    // euint32 ge;
    // euint32 gt;
    // euint32 le;
    // euint32 sub;
    euint32 sum;
    mapping(address => euint32) balances;

    function add(bytes memory encryptedAmount, uint16 amount) public {
        // sum = TFHE.add(sum, TFHE.asEuint32(encryptedAmount));
        // uint32 eight = 8;
        // sum = TFHE.add(sum, eight);

        balances[msg.sender] = TFHE.add(
            balances[msg.sender],
            balances[address(this)]
        );

        // sum = TFHE.add(sum, TFHE.asEuint32(encryptedAmount));
        // sum = TFHE.add(sum, TFHE.asEuint32(encryptedAmount));

        // euint8 ex = TFHE.asEuint8(5);
        // uint16 y = 1337;
        // euint32 asdf = TFHE.asEuint32(10000);

        // and = TFHE.and(ex, y);
        // or = TFHE.or(ex, y);
        // xor = TFHE.xor(ex, y);
        // eq = TFHE.eq(y, ex);
        // ge = TFHE.ge(y, ex);
        // gt = TFHE.gt(y, ex);
        // le = TFHE.le(ex, asdf);
        // TFHE.req(le);
        // sub = TFHE.sub(ex, asdf);
    }

    // function getAnd(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(and, publicKey);
    // }

    // function getOr(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(or, publicKey);
    // }

    // function getXor(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(xor, publicKey);
    // }

    // function getEq(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(eq, publicKey);
    // }

    // function getGe(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(ge, publicKey);
    // }

    // function getGt(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(gt, publicKey);
    // }

    // function getLe(bytes32 publicKey) public view returns (bytes memory) {
    //     return TFHE.reencrypt(le, publicKey);
    // }

    function getSum(bytes32 publicKey) public view returns (bytes memory) {
        return TFHE.reencrypt(balances[msg.sender], publicKey);
    }
}
