# Get Started on Ethereum Sepolia

Our testnet is up and running on Ethereum Sepolia.

## Network Information

If you need access to a Sepolia node and aren’t sure how to proceed, consider using a node provider like Alchemy, Infura, or similar services. These providers offer easy setup and management, allowing you to create an API key to connect to the network seamlessly.

## Important environmental variables

Save this in your `.env` file:

| Contract/Service       | Address/Value                                    |
| ---------------------- | ------------------------------------------------ |
| TFHE_EXECUTOR_CONTRACT | 0x199fB61DFdfE46f9F90C9773769c28D9623Bb90e       |
| ACL_CONTRACT           | 0x9479B455904dCccCf8Bc4f7dF8e9A1105cBa2A8e       |
| PAYMENT_CONTRACT       | 0x25FE5d92Ae6f89AF37D177cF818bF27EDFe37F7c       |
| KMS_VERIFIER_CONTRACT  | 0x904Af2B61068f686838bD6257E385C2cE7a09195       |
| GATEWAY_CONTRACT       | 0x7455c89669cdE1f7Cb6D026DFB87263422D821ca       |
| PUBLIC_KEY_ID          | 55729ddea48547ea837137d122e1c90043e94c41         |
| GATEWAY_URL            | https://gateway-sepolia.kms-dev-v1.bc.zama.team/ |

## Getting test ETH

You can get test ETH for Sepolia from these faucets:

- [Alchemy Sepolia Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
- [QuickNode Sepolia Faucet](https://faucet.quicknode.com/ethereum/sepolia)

## Configuring Sepolia on your wallet

Most Ethereum wallets have built-in support for testnets like Sepolia. You can add Sepolia to your wallet in two ways:

1. **Automatic Configuration**:
   Many wallets like MetaMask have Sepolia pre-configured. Simply open your network selector and choose "Show/hide test networks" to enable testnet visibility.

2. **Manual Configuration**: The exact steps for manual configuration will vary by wallet, but generally involve:
   1. Opening network settings
   2. Selecting "Add Network" or "Add Network Manually"
   3. Filling in the above information
   4. Saving the configuration
