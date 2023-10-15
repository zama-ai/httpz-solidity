import { ethers } from 'hardhat';

import type { DecentralizedId } from '../../types';
import { getSigners } from '../signers';

export async function deployDIDFixture(): Promise<DecentralizedId> {
  const signers = await getSigners();

  const contractFactory = await ethers.getContractFactory('DecentralizedId');
  const contract = await contractFactory.connect(signers.alice).deploy();
  await contract.waitForDeployment();

  return contract;
}
