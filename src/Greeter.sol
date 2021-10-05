// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

library Errors {
    string internal constant InvalidBlockNumber =
        "invalid block number, please wait";
    string internal constant CannotGm = "cannot greet with gm";
}

contract Greeter is Ownable {
    string public greeting;

    function authedGreet(string memory _greeting) public {
        require(_msgSender() == owner() || _msgSender() == address(1), Errors.CannotGm);
        greeting = _greeting;
    }
}
