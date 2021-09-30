// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

library Errors {
    string internal constant InvalidBlockNumber =
        "invalid block number, please wait";
    string internal constant CannotGm = "cannot greet with gm";
}

contract Vault is Ownable, Initializable {
    string public greeting;

    IERC20 public lpToken;
    IERC20 public tokenA;
    IERC20 public tokenB;

    function initialize(address owner, address _lpToken, address _tokenA, address _tokenB) public initializer {
        lpToken = IERC20(_lpToken);
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        transferOwnership(owner);
    }

    function gm() public onlyOwner {
        require(block.number % 10 == 0, Errors.InvalidBlockNumber);
        greeting = "gm";
    }

    function withdraw(uint256 amount) public onlyOwner {
        lpToken.transfer(owner(), amount);
    }
}
