// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Registry} from "../src/Registry.sol";
import {DeployRegistry} from "../script/DeployRegistry.s.sol";
import {MyNft} from "../src/MyNft.sol";
import {AccountImplementation} from "../src/AccountImplementation.sol";

contract RegistryTest is Test {
    Registry registry;
    DeployRegistry deployer;
    MyNft myNft;
    AccountImplementation accountImplementation;
    bytes32 constant SALT = bytes32(0x0);
    address USER = makeAddr("USER");
    address randomUser = makeAddr("randomUser");

    function setUp() external {
        deployer = new DeployRegistry();
        registry = deployer.run();
        vm.deal(USER, 100e18);
        vm.startPrank(USER);
        myNft = new MyNft();
        myNft.mint(randomUser);
        vm.stopPrank();
        accountImplementation = new AccountImplementation();

        vm.deal(randomUser, 100e18);
    }

    function testRejistryComputeTheSameAddressAsCreate() public {
        // address implementation, // the minimal proxy implementation => Account contract
        // bytes32 salt, // random salt to create unique address
        // uint256 chainId,
        // address tokenContract, // MyNft contract address
        // uint256 tokenId

        address computedAccountAddress = registry.account(
            address(accountImplementation),
            SALT,
            block.chainid,
            address(myNft),
            myNft.tokenId() - 1
        );

        console.log("Computed Account Address: ", computedAccountAddress);

        address actualAccountAddress = registry.createAccount(
            address(accountImplementation),
            SALT,
            block.chainid,
            address(myNft),
            myNft.tokenId() - 1
        );

        console.log("Actual Account Address: ", actualAccountAddress);

        assertEq(computedAccountAddress, actualAccountAddress);
    }

    function testTheAccountAddressIsValid() public {
        address burnerAccountAddress = registry.createAccount(
            address(accountImplementation),
            SALT,
            block.chainid,
            address(myNft),
            myNft.tokenId() - 1
        );

        // USER mint the NFT tokenId 0

        // let's say transfer 1 ether to the USER
        bytes memory data = abi.encodeWithSignature(
            "execute(address,uint256,bytes,uint8)",
            USER,
            1e18,
            "",
            uint8(0)
        );
        vm.prank(randomUser);
        (bool success, ) = burnerAccountAddress.call{value: 1e18}(data);
        assert(success);

        assertEq(USER.balance, 101e18);
    }
}
