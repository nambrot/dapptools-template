// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Vault.sol";
import "./Hevm.sol";
import "@openzeppelin/contracts/mocks/ERC20Mock.sol";

contract User {
    Vault internal vault;

    function setVault(Vault _vault) public {
        vault = _vault;
    }

    function withdraw(uint256 amount) public {
        vault.withdraw(amount);
    }
}

contract VaultTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    Vault internal vault;
    ERC20Mock internal token;

    // users
    User internal owner;
    User internal manager;

    function setUp() public virtual {
        vault = new Vault();

        owner = new User();
        owner.setVault(vault);
        manager = new User();
        manager.setVault(vault);

        token = new ERC20Mock("MockToken", "MOCK", address(owner), 0);

        vault.initialize(address(owner), address(token), address(token), address(token));
    }
}
