// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

library Errors {
    string internal constant InvalidBlockNumber =
        "invalid block number, please wait";
    string internal constant CannotGm = "cannot greet with gm";
}


contract Vault is Initializable, Ownable {
    address public last;
    function initialize(address owner) public initializer {
        transferOwnership(owner);
    }

    function deposit(address token, uint256 amount) public onlyOwner {
        IERC20 tokenC = IERC20(token);
        tokenC.transferFrom(msg.sender, address(this), amount);
    }

    function gm() public onlyOwner {
        last = msg.sender;
    }
 }