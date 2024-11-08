// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {Registry} from "../src/Registry.sol";

contract DeployRegistry is Script {
    address anvilAccount = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external returns (Registry) {
        vm.startBroadcast(anvilAccount);
        Registry registry = new Registry();
        vm.stopBroadcast();

        return registry;
    }
}
