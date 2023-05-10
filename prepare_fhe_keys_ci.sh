#!/bin/bash

set -Eeuo pipefail

NETWORK_KEYS_PUBLIC_PATH=./keys/network-public-fhe-keys
USERS_KEYS_PATH=./keys/users-fhe-keys
S3_BUCKET_PATH="s3://zbc-testnet"
S3_NETWORK_KEYS_PATH="$S3_BUCKET_PATH/network-fhe-keys"
S3_NETWORK_KEYS_FULL_PATH="$S3_NETWORK_KEYS_PATH/high_level_8_16_32"
S3_USERS_KEYS_PATH="$S3_BUCKET_PATH/users-fhe-keys"
S3_USERS_KEYS_FULL_PATH="$S3_USERS_KEYS_PATH/high_level_8_16_32"

mkdir -p $NETWORK_KEYS_PUBLIC_PATH
mkdir -p $USERS_KEYS_PATH

key="global_uncompressed_pks.bin"
echo "Downloading $key from $S3_NETWORK_KEYS_FULL_PATH to $NETWORK_KEYS_PUBLIC_PATH, please wait ..."
aws s3 cp $S3_NETWORK_KEYS_FULL_PATH/$key $NETWORK_KEYS_PUBLIC_PATH/pks

key="alice_cks.bin"
echo "Downloading $key to $USERS_KEYS_PATH, please wait ..."
aws s3 cp $S3_USERS_KEYS_FULL_PATH/$key $USERS_KEYS_PATH/alice_cks.bin

key="bob_cks.bin"
echo "Downloading $key to $USERS_KEYS_PATH, please wait ..."
aws s3 cp $S3_USERS_KEYS_FULL_PATH/$key $USERS_KEYS_PATH/bob_pks.bin

key="carol_cks.bin"
echo "Downloading $key to $USERS_KEYS_PATH, please wait ..."
aws s3 cp $S3_USERS_KEYS_FULL_PATH/$key $USERS_KEYS_PATH/carol_pks.bin

