#!/bin/bash
npx hardhat clean

PRIVATE_KEY_GATEWAY_DEPLOYER=$(grep PRIVATE_KEY_GATEWAY_DEPLOYER .env | cut -d '"' -f 2)
PRIVATE_KEY_FHEVM_DEPLOYER=$(grep PRIVATE_KEY_FHEVM_DEPLOYER .env | cut -d '"' -f 2)
NUM_KMS_SIGNERS=$(grep NUM_KMS_SIGNERS .env | cut -d '"' -f 2)
IS_COPROCESSOR=$(grep IS_COPROCESSOR .env | cut -d '"' -f 2)

npx hardhat task:computeGatewayAddress --private-key "$PRIVATE_KEY_GATEWAY_DEPLOYER"
npx hardhat task:computeACLAddress --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER"
npx hardhat task:computeTFHEExecutorAddress --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER"
npx hardhat task:computeKMSVerifierAddress --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER"
npx hardhat task:computeInputVerifierAddress --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --use-address true
npx hardhat task:computeFHEPaymentAddress --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER"

# [ADD DOCKER-COMPOSE COMMAND HERE] // Geth node, Gateway service, KMS service etc should be launched here, using previously precomputed addresses

npx hardhat compile:specific --contract lib
npx hardhat compile:specific --contract gateway

npx hardhat task:deployACL --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --network sepolia
npx hardhat task:deployTFHEExecutor --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --network sepolia
npx hardhat task:deployKMSVerifier --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --network sepolia
npx hardhat task:deployInputVerifier --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --network sepolia
npx hardhat task:deployFHEPayment --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --network sepolia

npx hardhat task:addSigners --num-signers $NUM_KMS_SIGNERS --private-key "$PRIVATE_KEY_FHEVM_DEPLOYER" --use-address true --network sepolia

npx hardhat task:launchFhevm --skip-get-coin true --use-address true --network sepolia

echo "Waiting 2 minutes before contract verification... Please wait..."
sleep 120 # makes sure that contracts bytescode propagates on Etherscan, otherwise contracts verification might fail in next step
npx hardhat task:verifyContracts --network sepolia