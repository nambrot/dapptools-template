// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Vault.sol";
import "./Hevm.sol";

contract User {
    Vault internal greeter;

    constructor(address _greeter) {
        greeter = Vault(_greeter);
    }

    function greet(string memory greeting) public {
        greeter.greet(greeting);
    }

    function gm() public {
        greeter.gm();
    }
}

contract VaultTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    Vault internal greeter;

    // users
    User internal alice;
    User internal bob;

    function setUp() public virtual {
        greeter = new Vault();
        alice = new User(address(greeter));
        bob = new User(address(greeter));
        greeter.transferOwnership(address(alice));
    }
}
