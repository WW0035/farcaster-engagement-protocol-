// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IReputation.sol";

contract MerkleRewardDistributor is Ownable {

    IERC20 public token;
    bytes32 public root;
    IReputation public reputation;

    uint256 public minScore;

    mapping(address => bool) public claimed;

    constructor(address _token, bytes32 _root, address _rep) Ownable(msg.sender) {
        token = IERC20(_token);
        root = _root;
        reputation = IReputation(_rep);
    }

    function claim(uint256 amount, bytes32[] calldata proof) external {
        require(!claimed[msg.sender], "claimed");
        require(reputation.getScore(msg.sender) >= minScore, "low score");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(proof, root, leaf), "invalid");

        claimed[msg.sender] = true;
        token.transfer(msg.sender, amount);
    }
}
