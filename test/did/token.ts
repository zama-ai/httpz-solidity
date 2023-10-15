export type EIP712Type = { name: string; type: string };

export type EIP712 = {
  domain: {
    chainId: number;
    name: string;
    verifyingContract: string;
    version: string;
  };
  message: {
    [key: string]: any;
  };
  primaryType: string;
  types: {
    [key: string]: EIP712Type[];
  };
};

export const getToken = (chainId: number, verifyingContract: string, name: string, allowed: string): EIP712 => ({
  types: {
    // Refer to primaryType.
    DecentralizedId: [
      { name: 'identifier', type: 'string' },
      { name: 'allowed', type: 'address' },
    ],
  },
  // This defines the message you're proposing the user to sign, is dapp-specific, and contains
  // anything you want. There are no required fields. Be as explicit as possible when building out
  // the message schema.
  // This refers to the keys of the following types object.
  primaryType: 'DecentralizedId',
  domain: {
    // Give a user-friendly name to the specific contract you're signing for.
    name: 'Authorization token',
    // This identifies the latest version.
    version: '1',
    // This defines the network, in this case, Mainnet.
    chainId,
    // // Add a verifying contract to make sure you're establishing contracts with the proper entity.
    verifyingContract,
  },
  message: {
    identifier: name,
    allowed,
  },
});
