import { expect } from 'chai';
import hre from 'hardhat';

import { createInstances } from '../instance';
import { getSigners, initSigners } from '../signers';

const ethers = hre.ethers;

describe('EncryptedCounter1', function () {
  before(async function () {
    await initSigners(2);
    this.signers = await getSigners();
    console.log('Create fhevmjs instance');
    this.instances = await createInstances(this.signers);

    const CounterFactory = await ethers.getContractFactory('EncryptedCounter3');

    console.log('Deploying contract');
    this.counterContract = await CounterFactory.connect(this.signers.alice).deploy();
    await this.counterContract.waitForDeployment();
    this.contractAddress = await this.counterContract.getAddress();
    console.log('Contract deployed');
  });

  it('env', async function () {
    console.log(process.env.HELLO);
  });

  it('should increment the counter by fixed amount', async function () {
    // Call increment
    console.log('Calling increment on contract');
    const tx1 = await this.counterContract.increment();
    console.log('Contract called, waiting for transaction');
    await tx1.wait();
    console.log('Transaction completed');

    // Request decryption
    console.log('Requesting decryption');
    const tx2 = await this.counterContract.connect(this.signers.alice).requestDecryptCounter();
    console.log('Contract called, waiting for transaction');
    await tx2.wait();
    console.log('Transaction completed');

    // Wait for decryption to complete
    console.log('Waiting 30s for decryption callback to complete');
    await new Promise((resolve) => setTimeout(resolve, 30000));

    // Check decrypted value (should be 1: initial 0 + one increment)
    console.log('Checking decrypted value');
    const decryptedValue1 = await this.counterContract.getDecryptedCounter();
    console.log(decryptedValue1);
    expect(decryptedValue1).to.equal(1);
  });

  it('should increment the counter by encrypted amount', async function () {
    // Encrypt inputs
    const address = await this.signers.alice.getAddress();
    console.log('Encrypting inputs');
    const input = this.instances.createEncryptedInput(this.contractAddress, address);
    input.add8(5); // Increment by 5 as an example
    const encryptedAmount = await input.encrypt();
    console.log('Inputs encrypted');

    // Call incrementBy with encrypted amount
    console.log('Calling incrementBy on contract');
    const tx1 = await this.counterContract.incrementBy(encryptedAmount.handles[0], encryptedAmount.inputProof);
    console.log('Contract called, waiting for transaction');
    await tx1.wait();
    console.log('Transaction completed');

    // Request decryption
    console.log('Requesting decryption');
    const tx2 = await this.counterContract.connect(this.signers.alice).requestDecryptCounter();
    console.log('Contract called, waiting for transaction');
    await tx2.wait();
    console.log('Transaction completed');

    // Wait for decryption to complete
    console.log('Waiting 30s for decryption callback to complete');
    await new Promise((resolve) => setTimeout(resolve, 30000));

    // Check decrypted value (should be 1: initial 0 + one increment)
    console.log('Checking decrypted value');
    const decryptedValue1 = await this.counterContract.getDecryptedCounter();
    console.log(decryptedValue1);
    expect(decryptedValue1).to.equal(5);
  });
});
