import { ethers } from 'hardhat';

import { getSigners, initSigners } from '../signers';

describe('TestAsyncDecrypt', function () {
  before(async function () {
    await initSigners(3);
    this.signers = await getSigners();
  });

  it('fheEq', async function () {
    const contractFactory2 = await ethers.getContractFactory('TestEq');
    const contract2 = await contractFactory2.connect(this.signers.alice).deploy();
    const res = await contract2.r();
    console.log(res);
  });
});
