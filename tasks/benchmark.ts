import { task, types } from 'hardhat/config';
import type { TaskArguments } from 'hardhat/types';
import fhevmjs from 'fhevmjs';

task('task:benchmark')
    .addParam('privKey', 'Private key of the main account')
    .addOptionalParam(
        "numberOfTxInParallel",
        "Number of tx we want to run in parallel",
        3,
        types.int
    )
    .setAction(async function (taskArguments: TaskArguments, { ethers }) {
        const NUMBER_OF_ACCOUNT = taskArguments.numberOfTxInParallel;

        let wallets = [];
        let contracts = [];
        const provider = ethers.provider;

        // Replace this with the private key of your funded account
        const senderPrivateKey = taskArguments.privKey;
        const senderWallet = new ethers.Wallet(senderPrivateKey, provider);

        // Create wallets 
        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = ethers.Wallet.createRandom().connect(provider);
            wallets.push(wallet);
        }

        // let sendPromises = [];
        // Send Ether to the wallet
        let nonce = await provider.getTransactionCount(senderWallet.address);

        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = wallets[i];
            const tx = await senderWallet.sendTransaction({
                to: wallet.address,
                value: ethers.parseEther('1.0'),
                nonce: nonce++
            });
            await tx.wait()
            console.log(`[${i + 1}/${NUMBER_OF_ACCOUNT}] Sent 1 Ether to ${wallet.address}`);
        }
        // await Promise.all(sendPromises.map(async (tx) => (await tx).wait()));


        let deployPromises = [];
        // Deploy the contracts
        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = wallets[i];
            const erc20Factory = await ethers.getContractFactory('EncryptedERC20', wallet);
            const contractTx = erc20Factory.deploy();
            deployPromises.push(contractTx)

        }
        let contractsResolved = await Promise.all(deployPromises.map(async (tx) => ((await tx).waitForDeployment())));
        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = wallets[i];
            contracts.push(contractsResolved[i]);
            console.log(`Contract deployed by ${wallet.address} at ${await contractsResolved[i].getAddress()}`);

        }

        const network = await provider.getNetwork();
        const chainId = +network.chainId.toString(); // Need to be a number

        // Get blockchain public key
        const publicKey = await provider.call({
            to: '0x0000000000000000000000000000000000000044',
        });

        // Create an instance
        const instance = await fhevmjs.createInstance({ chainId, publicKey });


        // Prepare encrypted inputs
        let encryptedAmountMint = instance.encrypt32(10000);
        let encryptedAmountTransfer = instance.encrypt32(10);


        let mintPromises = [];
        // Call a mint on each contract
        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = wallets[i];
            const contract = contracts[i];
            const mintTx = await contract.connect(wallet).mint(encryptedAmountMint);
            mintPromises.push(mintTx);
            console.log(`Called mint on contract at ${await wallets[i].getAddress()}`);
        }
        await Promise.all(mintPromises.map(tx => tx.wait()));


        let transfer = [];
        // Call a transfer on each contract
        for (let i = 0; i < NUMBER_OF_ACCOUNT; i++) {
            const wallet = wallets[i];
            const contract = contracts[i];
            const transferTx = await contract.connect(wallet)['transfer(address,bytes)']("0x8B8f5091f8b9817EF69cFC1E8B2f721BafF60DF4", encryptedAmountTransfer);
            transfer.push(transferTx);
            console.log(`Called transfer on contract at ${await wallets[i].getAddress()}`);
        }
        await Promise.all(transfer.map(tx => tx.wait()));

    });
