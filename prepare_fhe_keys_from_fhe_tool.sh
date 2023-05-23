#!/bin/bash

set -Eeuo pipefail

if [ "$#" -ne 1 ]; then
    echo "Please give the path where all the keys are stored"
    exit
fi

NETWORK_KEYS_PUBLIC_PATH=./keys/network-public-fhe-keys
USERS_KEYS_PATH=./keys/users-fhe-keys
KEYS_FULL_PATH=$1

MANDATORY_KEYS_LIST=('global_uncompressed_pks.bin' 'alice_cks.bin' 'bob_cks.bin' 'carol_cks.bin')
 
echo "check folder $KEYS_FULL_PATH"
for key in "${MANDATORY_KEYS_LIST[@]}"
    do
        if [ ! -f "$KEYS_FULL_PATH/$key" ]; then
            echo "#####ATTENTION######"
            echo "$key does not exist!"
            echo "####################"
            exit
        else
            echo "$key exists, nice!"
        fi
done

mkdir -p $NETWORK_KEYS_PUBLIC_PATH
mkdir -p $USERS_KEYS_PATH

key="global_uncompressed_pks.bin"
echo "Copying $key to $NETWORK_KEYS_PUBLIC_PATH, please wait ..."
cp $KEYS_FULL_PATH/$key $NETWORK_KEYS_PUBLIC_PATH/pks

key="alice_cks.bin"
echo "Copying $key to $USERS_KEYS_PATH, please wait ..."
cp $KEYS_FULL_PATH/$key $USERS_KEYS_PATH/alice_cks.bin

key="bob_cks.bin"
echo "Copying $key to $USERS_KEYS_PATH, please wait ..."
cp $KEYS_FULL_PATH/$key $USERS_KEYS_PATH/bob_cks.bin

key="carol_cks.bin"
echo "Copying $key to $USERS_KEYS_PATH, please wait ..."
cp $KEYS_FULL_PATH/$key $USERS_KEYS_PATH/carol_cks.bin

