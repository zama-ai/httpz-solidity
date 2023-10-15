import { ethers } from 'hardhat';

import type { DidERC20 } from '../../types';
import { getSigners } from '../signers';

export async function deployDidERC20Fixture(didAddress: string): Promise<DidERC20> {
  const signers = await getSigners();

  const contractFactory = await ethers.getContractFactory('DidERC20');
  const contract = await contractFactory.connect(signers.alice).deploy(didAddress);
  await contract.waitForDeployment();

  return contract;
}
