// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ReputationEngine is Ownable {

    mapping(address => uint256) public score;

    function increaseReputation(address user, uint256 amount) external onlyOwner {
        score[user] += amount;
    }

    function getScore(address user) external view returns (uint256) {
        return score[user];
    }
}
