// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/VaultTest.sol";
import {Errors} from "../Vault.sol";

contract VaultAA is VaultTest {
    function testCannotGm() public {
        try alice.gm() {
            fail();
        } catch Error(string memory error) {
            assertEq(error, Errors.CannotGm);
        }
    }
}
