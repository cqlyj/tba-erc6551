// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MyNft} from "../src/MyNft.sol";

contract MintMyNft is Script {
    address anvilAccount = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address anvilAccount2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    function mintMyNft(address mostRecentlyDeployed) public {
        vm.startBroadcast(anvilAccount);

        MyNft myNft = MyNft(mostRecentlyDeployed);
        myNft.mint(anvilAccount2);

        vm.stopBroadcast();
        console.log("Minted MyNft to: ", anvilAccount2);
        console.log("Token ID: ", myNft.tokenId() - 1);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MyNft",
            block.chainid
        );

        console.log(
            "Most recently deployed MyNft contract: ",
            mostRecentlyDeployed
        );

        mintMyNft(mostRecentlyDeployed);
    }
}
