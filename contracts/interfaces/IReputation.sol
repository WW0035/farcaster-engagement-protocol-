// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IReputation {
    function increaseReputation(address user, uint256 amount) external;
    function getScore(address user) external view returns (uint256);
}
