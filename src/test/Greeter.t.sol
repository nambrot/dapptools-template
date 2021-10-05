// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/GreeterTest.sol";
import {Errors} from "../Greeter.sol";

// contract Greet is GreeterTest {
//     function testCannotGm() public {
//         try alice.greet("gm") {
//             fail();
//         } catch Error(string memory error) {
//             assertEq(error, Errors.CannotGm);
//         }
//     }

//     function testCanSetGreeting() public {
//         alice.greet("hi");
//         assertEq(greeter.greeting(), "hi");
//     }

//     function testWorksForAllGreetings(string memory greeting) public {
//         alice.greet(greeting);
//         assertEq(greeter.greeting(), greeting);
//     }
// }

// contract Gm is GreeterTest {
//     function testOwnerCanGmOnGoodBlocks() public {
//         hevm.roll(10);
//         alice.gm();
//         assertEq(greeter.greeting(), "gm");
//     }

//     function testOwnerCannotGmOnBadBlocks() public {
//         hevm.roll(11);
//         try alice.gm() {
//             fail();
//         } catch Error(string memory error) {
//             assertEq(error, Errors.InvalidBlockNumber);
//         }
//     }

//     function testNonOwnerCannotGm() public {
//         try bob.gm() {
//             fail();
//         } catch Error(string memory error) {
//             assertEq(error, "Ownable: caller is not the owner");
//         }
//     }
// }

contract AuthGreet is GreeterTest {
    function testOwnerCanAuthGreet() public {
        alice.authedGreet("gm");
    }

    function testNonOwnerCantAuthGreet() public {
        try bob.authedGreet("gm") {
            fail();
        } catch Error(string memory error) {
            assertEq(error, Errors.CannotGm);
        }
    }

    function testNooneCanAuthGreet() public {
        User user = new User(address(greeter));
        try user.authedGreet("gm") {
            fail();
        } catch Error(string memory error) {
            assertEq(error, Errors.CannotGm);
        }
    }
}

contract InvariantGreet is GreeterTest {
    address[] private targetContracts_;

    function setUp() public override {
        super.setUp();
        targetContracts_.push(address(greeter));
    }

    function targetContracts() public view returns (address[] memory) {
      return targetContracts_;
    }

    function invariantNoChange() public {
        // This invariant should not hold when called with the owner or 0x1
        assertEq(greeter.greeting(), "");
    }
}