// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {MyNft} from "../src/MyNft.sol";

contract DeployMyNft is Script {
    function run() external returns (MyNft) {
        vm.startBroadcast();
        MyNft myNft = new MyNft();
        vm.stopBroadcast();

        return myNft;
    }
}
