// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MyNft} from "../src/MyNft.sol";
import {Registry} from "../src/Registry.sol";
import {AccountImplementation} from "../src/AccountImplementation.sol";

contract CreateAccount is Script {
    bytes32 constant SALT = bytes32(0);
    address account;
    address anvilAccount = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address anvilAccount2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    // address implementation, // the minimal proxy implementation
    // bytes32 salt, // random salt to create unique address
    // uint256 chainId,
    // address tokenContract, // MyNft contract address
    // uint256 tokenId

    function createAccount(
        address mostRecentlyDeployed,
        address implementation,
        address tokenContract
    ) public returns (address) {
        vm.startBroadcast();

        Registry registry = Registry(mostRecentlyDeployed);
        uint256 tokenId = MyNft(tokenContract).tokenId() - 1;

        address createdAccount = registry.createAccount(
            implementation,
            SALT,
            block.chainid,
            tokenContract,
            tokenId
        );

        vm.stopBroadcast();

        console.log("Account created: ", createdAccount);
        return createdAccount;
    }

    function execute(address accountImplementationAddress) public {
        bytes memory data = abi.encodeWithSignature(
            "execute(address,uint256,bytes,uint8)",
            anvilAccount,
            1e18,
            "",
            uint8(0)
        );
        // the MyNft is minted to anvilAccount2
        vm.startBroadcast(anvilAccount2);

        (bool success, ) = accountImplementationAddress.call{value: 1e18}(data);
        if (!success) {
            console.log("Failed to execute transaction");
        }

        console.log("1 ethers transferred to anvilAccount");
        console.log("anvilAccount balance: ", address(anvilAccount).balance);
        console.log("anvilAccount2 balance: ", address(anvilAccount2).balance);

        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Registry",
            block.chainid
        );

        address implementationAddress = DevOpsTools.get_most_recent_deployment(
            "AccountImplementation",
            block.chainid
        );

        address myNftTokenContract = DevOpsTools.get_most_recent_deployment(
            "MyNft",
            block.chainid
        );

        console.log(
            "Most recently deployed Registry contract: ",
            mostRecentlyDeployed
        );

        account = createAccount(
            mostRecentlyDeployed,
            implementationAddress,
            myNftTokenContract
        );

        execute(account);
    }
}
