import { expect } from 'chai';
import { ethers } from 'hardhat';

import { createInstances } from '../instance';
import { getSigners, initSigners } from '../signers';
import { deployDIDFixture } from './DID.fixture';
import { deployDidERC20Fixture } from './DidERC20.fixture';

describe('DidERC20', function () {
  before(async function () {
    await initSigners(2);
    this.signers = await getSigners();
  });

  beforeEach(async function () {
    this.did = await deployDIDFixture();
    const didAddress = await this.did.getAddress();
    const contract = await deployDidERC20Fixture(didAddress);
    this.contractAddress = await contract.getAddress();
    this.didErc20 = contract;
    this.instances = await createInstances(this.contractAddress, ethers, this.signers);
  });

  it('should allow decryption of balance for did owner', async function () {
    const bobDid = 'did:zama:1234';
    const tx1 = await this.did.addId(bobDid, this.signers.bob.address);
    await tx1.wait();

    const encryptedAmount = this.instances.alice.encrypt32(10000);
    const transaction = await this.didErc20.mint(encryptedAmount);
    await transaction.wait();

    const encryptedTransferAmount = this.instances.alice.encrypt32(1337);
    const tx = await this.didErc20['transfer(address,bytes)'](this.signers.bob.address, encryptedTransferAmount);
    await tx.wait();

    // Call the method
    const token = this.instances.alice.getTokenSignature(this.contractAddress) || {
      signature: '',
      publicKey: '',
    };

    const encryptedBalance = await this.didErc20['balanceOf(address,bytes32,bytes)'](
      this.signers.bob.address,
      token.publicKey,
      token.signature,
    );

    // Decrypt the balance
    const balance = this.instances.alice.decrypt(this.contractAddress, encryptedBalance);
    expect(balance).to.equal(1337);

    const carolToken = this.instances.carol.getTokenSignature(this.contractAddress) || {
      signature: '',
      publicKey: '',
    };

    // It must throw since Carol is not owner of the did contract
    const bobBalance = this.didErc20
      .connect(this.signers.carol)
      ['balanceOf(address,bytes32,bytes)'](this.signers.bob.address, carolToken.publicKey, carolToken.signature);

    expect(bobBalance).to.throw;
  });
});
