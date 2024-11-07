// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {Registry} from "../src/Registry.sol";

contract DeployRegistry is Script {
    function run() external returns (Registry) {
        vm.startBroadcast();
        Registry registry = new Registry();
        vm.stopBroadcast();

        return registry;
    }
}
