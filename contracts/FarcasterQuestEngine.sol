// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IReputation.sol";

contract FarcasterQuestEngine is Ownable {

    IReputation public reputation;

    struct Quest {
        string name;
        uint256 reward;
        bool active;
    }

    Quest[] public quests;
    mapping(address => mapping(uint256 => bool)) public completed;

    constructor(address _rep) Ownable(msg.sender) {
        reputation = IReputation(_rep);
    }

    function createQuest(string memory name, uint256 reward) external onlyOwner {
        quests.push(Quest(name, reward, true));
    }

    function completeQuest(address user, uint256 questId) external onlyOwner {
        require(!completed[user][questId], "done");

        completed[user][questId] = true;
        reputation.increaseReputation(user, quests[questId].reward);
    }
}
