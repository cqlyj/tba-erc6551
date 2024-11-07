// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "lib/erc6551/src/interfaces/IERC6551Registry.sol";
import "@openzeppelin/contracts/utils/Create2.sol";
import {Account} from "./Account.sol";

contract Registry is IERC6551Registry {
    /**
     * @dev Creates a token bound account for a non-fungible token.
     *
     * If account has already been created, returns the account address without calling create2.
     *
     * Emits ERC6551AccountCreated event.
     *
     * @return _account The address of the token bound account
     */

    function createAccount(
        address implementation, // the minimal proxy implementation
        bytes32 salt, // random salt to create unique address
        uint256 chainId,
        address tokenContract, // MyNft contract address
        uint256 tokenId
    ) external returns (address _account) {
        bytes memory code = _accountCreationCode(
            implementation,
            salt,
            chainId,
            tokenContract,
            tokenId
        );
        bytes32 codeHash = keccak256(code);
        _account = Create2.computeAddress(salt, codeHash);
        // if the account already exists, return the address
        if (_account.code.length != 0) {
            return _account;
        }

        // deploy the account
        _account = Create2.deploy(0, salt, code);

        // if the account creation failed, revert
        if (_account == address(0)) {
            revert AccountCreationFailed();
        }

        emit ERC6551AccountCreated(
            _account,
            implementation,
            salt,
            chainId,
            tokenContract,
            tokenId
        );

        return _account;
    }

    /**
     * @dev Returns the computed token bound account address for a non-fungible token.
     *
     * @return _account The address of the token bound account
     */
    function account(
        address implementation,
        bytes32 salt,
        uint256 chainId,
        address tokenContract,
        uint256 tokenId
    ) external view returns (address _account) {
        bytes memory code = _accountCreationCode(
            implementation,
            salt,
            chainId,
            tokenContract,
            tokenId
        );
        bytes32 codeHash = keccak256(code);
        return Create2.computeAddress(salt, codeHash);
    }

    /*//////////////////////////////////////////////////////////////
                            HELPER FUNCTION
    //////////////////////////////////////////////////////////////*/

    function _accountCreationCode(
        address implementation,
        bytes32 salt,
        uint256 chainId,
        address tokenContract,
        uint256 tokenId
    ) internal pure returns (bytes memory) {
        return
            abi.encodePacked(
                hex"363d3d373d3d3d363d73", // ERC-1167 Header(10 bytes)
                implementation,
                hex"5af43d82803e903d91602b57fd5bf3", // ERC-1167 Footer(15 bytes)
                abi.encode(salt, chainId, tokenContract, tokenId)
            );
    }
}
