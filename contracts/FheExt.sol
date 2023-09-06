contract FheExt {
    function add(uint256 lhs, uint256 rhs, bool scalar) public view returns (uint256 result) {
        bytes1 scalarByte;
        if (scalar) {
            scalarByte = 0x01;
        } else {
            scalarByte = 0x00;
        }
        bytes memory input = bytes.concat(bytes32(lhs), bytes32(rhs), scalarByte);
        uint256 inputLen = input.length;

        bytes32[1] memory output;
        uint256 outputLen = 32;
        // Call the add precompile.
        uint256 precompile = 65;
        assembly {
            // jump over the 32-bit 'size' field of the 'bytes' data structure of the 'input' to read actual bytes
            if iszero(staticcall(gas(), precompile, add(input, 32), inputLen, output, outputLen)) {
                revert(0, 0)
            }
        }

        result = uint256(output[0]);
    }

    function trivialEncrypt(uint256 value, uint8 toType) internal view returns (uint256 result) {
        bytes memory input = bytes.concat(bytes32(value), bytes1(toType));
        uint256 inputLen = input.length;

        bytes32[1] memory output;
        uint256 outputLen = 32;

        // Call the trivialEncrypt precompile.
        uint256 precompile = 77;
        assembly {
            // jump over the 32-bit 'size' field of the 'bytes' data structure of the 'input' to read actual bytes
            if iszero(staticcall(gas(), precompile, add(input, 32), inputLen, output, outputLen)) {
                revert(0, 0)
            }
        }
        result = uint256(output[0]);
    }
}
