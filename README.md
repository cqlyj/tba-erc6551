# Token Bounded Account - ERC6551 - Minimal Walkthrough

This project is a minimal walkthrough of the ERC6551 standard. The ERC6551 standard is a token bounded account standard that allows for the creation of a token that is bound to an account. This means that the token can only be transferred to the account that it is bound to.

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

```
git clone https://github.com/cqlyj/tba-erc6551
cd tba-erc6551
make
```

## Testing

Run:

```
forge test
```

# Usage - Walkthrough the ERC6551 standard

1. Set up your environment variables:

```bash
cp .env.example .env
```

If you just want to run this in local anvil chain, the .env.example already have those pre-configured. You can just delete other env variables.

2. Spin up a local anvil chain:

```bash
make anvil
```

3. Spin up a new terminal and run:

```bash
make walk-through
```

Then you can see that we first deploy `MyNft` contract, then deploy `Registry` contract, then deploy `AccountImplementation` contract with the anvil account index 0.
Mint the NFT to the anvil account index 1, then `createAccount` and try to execute function in the `AccountImplementation` contract. Here we just send 1 ethers to the anvil account index 0.
You can see outputs log below:

```bash
== Logs ==
  Most recently deployed Registry contract:  0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
  Account created:  0x026091B08c11e2F39f1e0E9a9599dbf732824300
  1 ethers transferred to anvilAccount
  anvilAccount balance:  10000998121551806573964
  anvilAccount2 balance:  9999000000000000000000
```

We successfully transferred 1 ethers to the anvil account index 0. Since the owner of Nft is anvil account index 1, so the balance of anvil account index 1 is deducted by 1 ethers.

You can try change the address to other address rather than the anvil account index 1, the transaction will revert since the NFT is not owned by other address.
Simply change the code in `RegistryInteractions.s.sol`:

```diff
function execute(address accountImplementationAddress) public {
        bytes memory data = abi.encodeWithSignature(
            "execute(address,uint256,bytes,uint8)",
            anvilAccount,
            1e18,
            "",
            uint8(0)
        );
        // the MyNft is minted to anvilAccount2
-       vm.startBroadcast(anvilAccount2);
+       // Any address other than anvilAccount2 will revert, here we change to anvilAccount.
+       vm.startBroadcast(anvilAccount);

        (bool success, ) = accountImplementationAddress.call{value: 1e18}(data);
        if (!success) {
            console.log("Failed to execute transaction");
        }

        console.log("1 ethers transferred to anvilAccount");
        console.log("anvilAccount balance: ", address(anvilAccount).balance);
        console.log("anvilAccount2 balance: ", address(anvilAccount2).balance);

        vm.stopBroadcast();
    }
```

Then you can see output like this:

```bash
 [74039] 0x0165878A594ca255338adfa4d48449f69242Eb8F::createAccount(0xa513E6E4b8f2a923D98304ec87F64353C4D5C853, 0x0000000000000000000000000000000000000000000000000000000000000000, 31337 [3.133e4], 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707, 0)
    ├─ [34655] → new <unknown>@0xf6917B9Cb25FEBec3c14c12404436C12A9DeE19d
    │   └─ ← [Return] 173 bytes of code
    ├─ emit ERC6551AccountCreated(account: 0xf6917B9Cb25FEBec3c14c12404436C12A9DeE19d, implementation: 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853, salt: 0x0000000000000000000000000000000000000000000000000000000000000000, chainId: 31337 [3.133e4], tokenContract: 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707, tokenId: 0)
    └─ ← [Return] 0xf6917B9Cb25FEBec3c14c12404436C12A9DeE19d

  [9674] 0xf6917B9Cb25FEBec3c14c12404436C12A9DeE19d::execute{value: 1000000000000000000}(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 1000000000000000000 [1e18], 0x, 0)
    ├─ [6979] 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853::execute{value: 1000000000000000000}(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 1000000000000000000 [1e18], 0x, 0) [delegatecall]
    │   ├─ [2642] 0x5FC8d32690cc91D4c39d9d3abcBD16989F875707::ownerOf(0) [staticcall]
    │   │   └─ ← [Return] 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    │   └─ ← [Revert] Account__InvalidSigner()
    └─ ← [Revert] Account__InvalidSigner()

Error: Simulated execution failed.
```

Yeah, we have a `Account__InvalidSigner` error.

## Contact

Luo Yingjie - [luoyingjie0721@gmail.com](luoyingjie0721@gmail.com)
