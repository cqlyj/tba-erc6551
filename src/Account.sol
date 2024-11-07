// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IERC6551Account} from "lib/erc6551/src/interfaces/IERC6551Account.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import {IERC1271} from "@openzeppelin/contracts/interfaces/IERC1271.sol";

// All token bound accounts SHOULD be created via the singleton registry.

// All token bound account implementations MUST implement ERC-165 interface detection.

// All token bound account implementations MUST implement ERC-1271 signature validation.

contract Account is IERC6551Account, IERC165, IERC1271 {
    /*//////////////////////////////////////////////////////////////
                            IERC6551ACCOUNT
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Allows the account to receive Ether.
     *
     * Accounts MUST implement a `receive` function.
     *
     * Accounts MAY perform arbitrary logic to restrict conditions
     * under which Ether can be received.
     */
    receive() external payable {}

    /**
     * @dev Returns the identifier of the non-fungible token which owns the account.
     *
     * The return value of this function MUST be constant - it MUST NOT change over time.
     *
     * @return chainId       The EIP-155 ID of the chain the token exists on
     * @return tokenContract The contract address of the token
     * @return tokenId       The ID of the token
     */
    function token()
        external
        view
        returns (uint256 chainId, address tokenContract, uint256 tokenId)
    {}

    /**
     * @dev Returns a value that SHOULD be modified each time the account changes state.
     *
     * @return The current account state
     */
    function state() external view returns (uint256) {}

    /**
     * @dev Returns a magic value indicating whether a given signer is authorized to act on behalf
     * of the account.
     *
     * MUST return the bytes4 magic value 0x523e3260 if the given signer is valid.
     *
     * By default, the holder of the non-fungible token the account is bound to MUST be considered
     * a valid signer.
     *
     * Accounts MAY implement additional authorization logic which invalidates the holder as a
     * signer or grants signing permissions to other non-holder accounts.
     *
     * @param  signer     The address to check signing authorization for
     * @param  context    Additional data used to determine whether the signer is valid
     * @return magicValue Magic value indicating whether the signer is valid
     */
    function isValidSigner(
        address signer,
        bytes calldata context
    ) external view returns (bytes4 magicValue) {}

    /*//////////////////////////////////////////////////////////////
                                IERC165
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) external view returns (bool) {}

    /*//////////////////////////////////////////////////////////////
                                IERC1271
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Should return whether the signature provided is valid for the provided data
     * @param hash      Hash of the data to be signed
     * @param signature Signature byte array associated with _data
     */
    function isValidSignature(
        bytes32 hash,
        bytes memory signature
    ) external view returns (bytes4 magicValue) {}
}
