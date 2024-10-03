#!/bin/bash



PRIVATE_KEY_GATEWAY_DEPLOYER=$(grep PRIVATE_KEY_GATEWAY_DEPLOYER .env | cut -d '"' -f 2)
NUM_KMS_SIGNERS=$(grep NUM_KMS_SIGNERS .env | cut -d '"' -f 2)

npx hardhat task:computePredeployAddress --private-key "$PRIVATE_KEY_GATEWAY_DEPLOYER"

echo "PRIVATE_KEY_GATEWAY_DEPLOYER: $PRIVATE_KEY_GATEWAY_DEPLOYER"
echo "NUM_KMS_SIGNERS: $NUM_KMS_SIGNERS"


npx hardhat task:computeACLAddress
npx hardhat task:computeTFHEExecutorAddress
npx hardhat task:computeKMSVerifierAddress
npx hardhat task:computeInputVerifierAddress
npx hardhat task:computeFHEPaymentAddress
npx hardhat compile:specific --contract lib
npx hardhat compile:specific --contract gateway
npx hardhat task:deployACL
npx hardhat task:deployTFHEExecutor
npx hardhat task:deployKMSVerifier
npx hardhat task:deployInputVerifier
npx hardhat task:deployFHEPayment

npx hardhat task:addSigners --num-signers $NUM_KMS_SIGNERS

npx hardhat task:launchFhevm --skip-get-coin true

