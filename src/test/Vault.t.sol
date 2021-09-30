// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/VaultTest.sol";
import {Errors} from "../Vault.sol";

contract VaultOwnership is VaultTest {
    function testOwnerCanWithdraw(uint256 amount) public {
        token.mint(address(vault), amount);
        owner.withdraw(amount);
    }

    function testManagerCanWithdraw(uint256 amount) public {
        token.mint(address(vault), amount);
        try manager.withdraw(amount) {
            fail();
        } catch Error(string memory error) {
            assertEq(error, "Ownable: caller is not the owner");
        }
    }

    function testNoOneCanWithdraw(uint256 amount, address anyone) public {
        if (anyone == address(owner) || amount == 0) {
            return;
        }

        token.mint(address(vault), amount);
        User user = User(anyone);
        user.setVault(vault);
        try user.withdraw(amount) {
            fail();
        } catch Error(string memory error) {
            assertEq(error, "Ownable: caller is not the owner");
        }
    }
}
