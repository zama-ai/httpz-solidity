from web3 import Web3
from eth_account import Account
from eth_account.signers.local import LocalAccount
from web3.middleware import construct_sign_and_send_raw_middleware
from solcx import compile_standard, install_solc
import json
import subprocess
import time
import os
import argparse

os.chdir("./types")


def transfer(contract, to, account, amount):
    # TODO: use public key encryption instead
    os.system("../zbc-fhe encrypt-public-integer {} bin ciphertext $PWD/../keys/global_uncompressed_pks.bin bin".format(amount))

    file = open('./res/ct/ciphertext.bin', mode='rb')
    input = file.read()
    file.close()
    print('Input len =', len(input))

    # estimate gas and send a mint transaction.
    print("estimating gas and sending mint transaction...")
    start = time.time()
    gas = contract.functions.transfer(to, input).estimate_gas({
        'value': 0,
        'from': account.address
    })
    print('transfer gas estimation =', gas)
    print('transfer gas estimation took %s seconds' % (time.time() - start))

    print("Sending transfer transaction...")
    start = time.time()
    tx = contract.functions.transfer(to, input).transact({
        'value': 0,
        'from': account.address,
    })
    transaction_hash = tx.hex()
    print('Transfer transaction hash: ', transaction_hash)
    print('Sending transfer transaction took %s seconds' %
          (time.time() - start))
    print("Waiting for transaction to be mined...")
    start = time.time()
    transaction_receipt = w3.eth.wait_for_transaction_receipt(transaction_hash)
    print('Mining transfer transaction took %s seconds' %
          (time.time() - start))
    assert transaction_receipt['status'] == 1


def reencrypt(contract, account, cks_file, ct_file, expected):
    print("Retrieving encrypted balance from chain...")
    start = time.time()

    ct = contract.functions.balanceOf().call({
        'from': account.address
    })
    print('len(ct) =', len(ct))
    print('retrieving alice\'s balance took %s seconds' %
          (time.time() - start))

    f = open(ct_file, "w+b")
    f.write(ct)
    f.close()

    res = subprocess.run(
        ['../zbc-fhe', 'decrypt-integer', ct_file, 'bin', cks_file, 'bin'], stdout=subprocess.PIPE)
    # assert res.stdout == str.encode('{}\n'.format(str(expected)))
    print(res.stdout)
    # print(expected)

parser = argparse.ArgumentParser("Main account address")
parser.add_argument(
    "private_key", help="The private key of main account without 0x.", type=str)
args = parser.parse_args()
print(f"Receive the following private key for main account {args.private_key}")


w3 = Web3(Web3.HTTPProvider('http://host.docker.internal:8545',
          request_kwargs={'timeout': 600}))

alice_private_key = "0x00468d407f31211e8f8fba671fa714be5ea3b1203c683dd999075b28f3eff2fd"
alice_account: LocalAccount = Account.from_key(alice_private_key)
print("Alice address : ")
print(alice_account.address)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(alice_account))

# bob_private_key = "0x04554c46d10b234939a611dfa3df14d167e4e725ec59e4f38a9bf1177a05ce8f"
# bob_account: LocalAccount = Account.from_key(bob_private_key)
# w3.middleware_onion.add(construct_sign_and_send_raw_middleware(bob_account))

carol_private_key = "0xa6c13a4776aee43e5b4da33acc30fa0a688f3271a46357b349d443b2d491f4b2"
carol_account: LocalAccount = Account.from_key(carol_private_key)
print("Carol address : ")
print(carol_account.address)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(carol_account))

# Change below to match chain specific information:
chain_id = 9000
# private key of the default account
private_key = '83F4BA49EA86F6C364E2F6E12360F77D8DFC3B533AED318467B76752D8B2F749'
account: LocalAccount = Account.from_key(private_key)
print("Main address: ")
print(account.address)

print("\n\n======== STEP 1: COMPILE AND DEPLOY SMART CONTRACT ========")

print("Compiling EncryptedERC20.sol...")
start = time.time()

with open("./examples/EncryptedERC20.sol", "r") as file:
    file_contents = file.read()

install_solc('0.8.13')
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"EncryptedERC20.sol": {"content": file_contents}},
        "settings": {
            "outputSelection": {
                "*": {
                    "*": ["abi", "metadata", "evm.bytecode", "evm.bytecode.sourceMap"]
                }
            }
        },
    },
    solc_version="0.8.13",
    allow_paths="./types/lib"
)
print('Contract compilation took %s seconds' % (time.time() - start))

print("Deploying contract...")
start = time.time()

bytecode = compiled_sol["contracts"]["EncryptedERC20.sol"]["EncryptedERC20"]["evm"]["bytecode"]["object"]
abi = json.loads(compiled_sol["contracts"]["EncryptedERC20.sol"]
                 ["EncryptedERC20"]["metadata"])["output"]["abi"]
EncryptedERC20 = w3.eth.contract(abi=abi, bytecode=bytecode)

nonce = w3.eth.getTransactionCount(account.address)

# build transaction
transaction = EncryptedERC20.constructor().buildTransaction(
    {
        "chainId": chain_id,
        "gasPrice": w3.eth.gas_price,
        "from": account.address,
        "nonce": nonce,
    }
)
# sign transaction
signed_transaction = w3.eth.account.sign_transaction(
    transaction, private_key=private_key)

# send transaction
transaction_hash = w3.eth.send_raw_transaction(
    signed_transaction.rawTransaction)

# wait for the transaction to be mined, and get the transaction receipt
print("waiting for transaction to be mined...")
transaction_receipt = w3.eth.wait_for_transaction_receipt(transaction_hash)
print(f"contract deployed at {transaction_receipt.contractAddress}")
print('contract deployment took %s seconds' % (time.time() - start))
assert transaction_receipt['status'] == 1

print("\n\n======== STEP 2: MINT 2 TOKENS ========")

# get contract adress and send mint transaction
contract_address = transaction_receipt.contractAddress

# create the contract and make sure we use a middleware to automatically sign calls.
contract = w3.eth.contract(address=contract_address, abi=abi)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(account))

# encrypt amount to mint
# TODO: use public key encryption heres
os.system("../zbc-fhe encrypt-public-integer 2 bin ciphertext $PWD/../keys/global_uncompressed_pks.bin bin")


file = open('./res/ct/ciphertext.bin', mode='rb')
input = file.read()
file.close()

print('Input len =', len(input))

# estimate gas and send a mint transaction.
print("estimating gas and sending mint transaction...")
start = time.time()
gas = contract.functions.mint(input).estimate_gas({
    'value': 0,
    'from': account.address
})
print('mint gas estimation =', gas)
print('mint gas estimation took %s seconds' % (time.time() - start))

start = time.time()
tx = contract.functions.mint(input).transact({
    'value': 0,
    'from': account.address
})
transaction_hash = tx.hex()
print('mint transaction hash:', transaction_hash)
# wait for the transaction to be mined, and get the transaction receipt
print("waiting for transaction to be mined...")
transaction_receipt = w3.eth.wait_for_transaction_receipt(transaction_hash)
print('mint transaction took %s seconds' % (time.time() - start))
assert transaction_receipt['status'] == 1

print("\n\n======== STEP 3: TRANSFER 1 TOKENS FROM MAIN TO ALICE ========")
transfer(contract, alice_account.address, account, 1)

print("\n\n======== STEP 4: Alice REENCRYPTS ITS BALANCE ========")
reencrypt(contract, alice_account,  "/home/keys/alice_cks.bin",
          "ct_to_decrypt.bin", 1)
