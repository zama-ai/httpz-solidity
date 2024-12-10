import { expect } from 'chai';
import { network } from 'hardhat';

import { getFHEGasFromTxReceipt } from '../coprocessorUtils';
import { createInstance } from '../instance';
import { getSigners, initSigners } from '../signers';
import { deployConfidentialERC20Fixture } from './ConfidentialERC20.fixture';

describe('ConfidentialERC20:FHEGas', function () {
  before(async function () {
    await initSigners();
    this.signers = await getSigners();
  });

  beforeEach(async function () {
    const contract = await deployConfidentialERC20Fixture();
    this.contractAddress = await contract.getAddress();
    this.erc20 = contract;
    this.fhevm = await createInstance();
  });

  it('gas consumed during transfer', async function () {
    const transaction = await this.erc20.mint(10000);
    const t1 = await transaction.wait();
    expect(t1?.status).to.eq(1);

    const input = this.fhevm.createEncryptedInput(this.contractAddress, this.signers.alice.address);
    input.add64(1337);
    const encryptedTransferAmount = await input.encrypt();
    const tx = await this.erc20['transfer(address,bytes32,bytes)'](
      this.signers.bob.address,
      encryptedTransferAmount.handles[0],
      encryptedTransferAmount.inputProof,
    );
    const t2 = await tx.wait();
    expect(t2?.status).to.eq(1);
    if (network.name === 'hardhat') {
      // `getFHEGasFromTxReceipt` function only works in mocked mode but gives same exact FHEGas consumed than on the real fhEVM
      const FHEGasConsumedTransfer = getFHEGasFromTxReceipt(t2);
      console.log('FHEGas Consumed during transfer', FHEGasConsumedTransfer);
    }
    // contrarily to FHEGas, native gas in mocked mode slightly differs from the real gas consumption on fhevm (underestimated by ~20%)
    console.log('Native Gas Consumed during transfer', t2.gasUsed);
  });

  it('gas consumed during transferFrom', async function () {
    const transaction = await this.erc20.mint(10000);
    await transaction.wait();

    const inputAlice = this.fhevm.createEncryptedInput(this.contractAddress, this.signers.alice.address);
    inputAlice.add64(1337);
    const encryptedAllowanceAmount = await inputAlice.encrypt();
    const tx = await this.erc20['approve(address,bytes32,bytes)'](
      this.signers.bob.address,
      encryptedAllowanceAmount.handles[0],
      encryptedAllowanceAmount.inputProof,
    );
    await tx.wait();

    const bobErc20 = this.erc20.connect(this.signers.bob);
    const inputBob2 = this.fhevm.createEncryptedInput(this.contractAddress, this.signers.bob.address);
    inputBob2.add64(1337); // below allowance so next tx should send token
    const encryptedTransferAmount2 = await inputBob2.encrypt();
    const tx3 = await bobErc20['transferFrom(address,address,bytes32,bytes)'](
      this.signers.alice.address,
      this.signers.bob.address,
      encryptedTransferAmount2.handles[0],
      encryptedTransferAmount2.inputProof,
    );
    const t3 = await tx3.wait();
    if (network.name === 'hardhat') {
      // `getFHEGasFromTxReceipt` function only works in mocked mode but gives same exact FHEGas consumed than on the real fhEVM
      const FHEGasConsumedTransferFrom = getFHEGasFromTxReceipt(t3);
      console.log('FHEGas Consumed during transfer', FHEGasConsumedTransferFrom);
    }
    // contrarily to FHEGas, native gas in mocked mode slightly differs from the real gas consumption on fhevm (underestimated by ~20%)
    console.log('Native Gas Consumed during transfer', t3.gasUsed);
  });
});
