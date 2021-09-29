// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Vault.sol";
import "./Hevm.sol";

contract User {
    Vault internal vault;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    function gm() public {
        vault.gm();
    }
}

contract VaultTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    Vault internal vault;

    // users
    User internal alice;
    User internal bob;

    function setUp() public virtual {
        vault = new Vault();
        vault.initialize(address(alice));
        alice = new User(address(vault));
        bob = new User(address(vault));
    }
}
