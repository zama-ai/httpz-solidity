import { expect } from 'chai';
import { ethers } from 'hardhat';

import { createInstances } from '../instance';
import { getSigners, initSigners } from '../signers';
import { deployDIDFixture } from './DID.fixture';
import { getToken } from './token';

describe('DecentralizedId', function () {
  before(async function () {
    await initSigners(3);
    this.signers = await getSigners();
  });

  beforeEach(async function () {
    const contract = await deployDIDFixture();
    this.contractAddress = await contract.getAddress();
    this.did = contract;
    this.instances = await createInstances(this.contractAddress, ethers, this.signers);
  });

  it('should get text value did', async function () {
    const bobDid = 'did:zama:1234';
    const tx1 = await this.did.addId(bobDid, this.signers.bob.address);
    await tx1.wait();

    const tx2 = await this.did.setIdentifier(bobDid, 'name', 'Wilson');
    await tx2.wait();

    const name = await this.did.connect(this.signers.carol).getIdentifier(bobDid, 'name');

    expect(name).to.be.equal('Wilson');
  });

  it('should add ebool identifier', async function () {
    const bobDid = 'did:zama:1234';
    const encryptedTrue = this.instances.alice.encrypt8(1);
    const tx1 = await this.did.addId(bobDid, this.signers.bob.address);
    await tx1.wait();

    const transaction = await this.did['setIdentifierBool(string,string,bytes)'](bobDid, 'legalAge', encryptedTrue);
    await transaction.wait();

    // Bob sign a token to give access to Carol
    const provider = ethers.provider;
    const network = await provider.getNetwork();
    const chainId = +network.chainId.toString(); // Need to be a number

    const bobToken = getToken(chainId, this.contractAddress, 'legalAge', this.signers.carol.address);
    const bobSignature = await this.signers.bob.signTypedData(bobToken.domain, bobToken.types, bobToken.message);
    // Carol use this token to access information
    const token = this.instances.carol.getTokenSignature(this.contractAddress) || {
      signature: '',
      publicKey: '',
    };

    const encryptedBool = await this.did
      .connect(this.signers.carol)
      .reencryptIdentifier(bobDid, 'legalAge', bobSignature, token.publicKey, token.signature);
    const bool = this.instances.carol.decrypt(this.contractAddress, encryptedBool);

    expect(bool).to.be.equal(1);
  });

  it('should add euint32 identifier', async function () {
    const bobDid = 'did:zama:1234';
    const tx1 = await this.did.addId(bobDid, this.signers.bob.address);
    await tx1.wait();

    const encryptedBirth = this.instances.alice.encrypt32(495873907);
    const transaction = await this.did['setIdentifier32(string,string,bytes)'](bobDid, 'birthdate', encryptedBirth);
    await transaction.wait();

    // Bob sign a token to give access to Carol
    const provider = ethers.provider;
    const network = await provider.getNetwork();
    const chainId = +network.chainId.toString(); // Need to be a number
    const bobToken = getToken(chainId, this.contractAddress, 'birthdate', this.signers.carol.address);
    const bobSignature = await this.signers.bob.signTypedData(bobToken.domain, bobToken.types, bobToken.message);

    // Carol use this token to access information
    const token = this.instances.carol.getTokenSignature(this.contractAddress) || {
      signature: '',
      publicKey: '',
    };

    const encryptedBirthdate = await this.did
      .connect(this.signers.carol)
      .reencryptIdentifier(bobDid, 'birthdate', bobSignature, token.publicKey, token.signature);
    const birthdate = this.instances.carol.decrypt(this.contractAddress, encryptedBirthdate);

    expect(birthdate).to.be.equal(495873907);
  });

  it('should remove did', async function () {
    const bobDid = 'did:zama:1234';
    const tx1 = await this.did.addId(bobDid, this.signers.bob.address);
    await tx1.wait();

    const encryptedBirth = this.instances.alice.encrypt32(495873907);
    const tx2 = await this.did['setIdentifier32(string,string,bytes)'](bobDid, 'birthdate', encryptedBirth);
    await tx2.wait();

    const tx3 = await this.did.removeId(bobDid);
    await tx3.wait();

    // Bob sign a token to give access to Carol
    const provider = ethers.provider;
    const network = await provider.getNetwork();
    const chainId = +network.chainId.toString(); // Need to be a number
    const bobToken = getToken(chainId, this.contractAddress, 'birthdate', this.signers.carol.address);
    const bobSignature = await this.signers.bob.signTypedData(bobToken.domain, bobToken.types, bobToken.message);

    // Carol use this token to access information
    const token = this.instances.carol.getTokenSignature(this.contractAddress) || {
      signature: '',
      publicKey: '',
    };

    expect(
      this.did
        .connect(this.signers.carol)
        .reencryptIdentifier(bobDid, 'birthdate', bobSignature, token.publicKey, token.signature),
    ).to.throw;
  });
});
