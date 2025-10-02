// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {IVerifier} from "./Verifier.sol";

contract Panagram is ERC1155, Ownable {
    error Panagram__IncorrectGuess();
    error Panagram__NoRoundWinner();
    error Panagram__AlreadyAnsweredCorrectly();
    error Panagram__InvalidTokenId();
    error Panagram__FirstPanagramNotSet();
    error Panagram__MinTimeNotPassed(uint256 mintTimePassed, uint256 currentTimePassed);

    uint256 public constant MIN_DURATION = 10800; // 3 hours

    IVerifier public s_verifier;
    uint256 public s_roundStartTime;
    bytes32 public s_answer; // hash of the answer
    uint256 public s_currentRound;
    address public s_currentRoundWinner;

    mapping(address => uint256) public s_winnerWins;
    mapping(address => uint256) public s_lastCorrectGuessRound;

    event Panagram__VerifierUpdated(IVerifier verifier);
    event Panagram__RoundStarted();
    event Panagram__NFTMinted(address winner, uint256 tokenId);
    event Panagram__ProofSucceeded(bool result);

    constructor(IVerifier _verifier) ERC1155("ipfs://bafybeicqfc4ipkle34tgqv3gh7gccwhmr22qdg7p6k6oxon255mnwb6csi/{id}.json") Ownable(msg.sender) {
        s_verifier = _verifier;
    }

    function newRound(bytes32 _correctAnswer) external onlyOwner {
        if (s_roundStartTime == 0) {
            s_roundStartTime = block.timestamp;
            s_answer = _correctAnswer;
        } else {
            if (block.timestamp < s_roundStartTime + MIN_DURATION) revert Panagram__MinTimeNotPassed(MIN_DURATION, block.timestamp - s_roundStartTime);
            if (s_currentRoundWinner == address(0)) revert Panagram__NoRoundWinner();

            s_answer = _correctAnswer;
            s_currentRoundWinner = address(0);
        }

        s_currentRound++;

        emit Panagram__RoundStarted();
    }

    function makeGuess(bytes calldata proof) external returns (bool) {
        if (s_currentRound == 0) revert Panagram__FirstPanagramNotSet();
        if (s_lastCorrectGuessRound[msg.sender] == s_currentRound) revert Panagram__AlreadyAnsweredCorrectly();

        bytes32[] memory inputs = new bytes32[](2);
        inputs[0] = s_answer;
        inputs[1] = bytes32(uint256(uint160(msg.sender))); // hard code to prevent front-running!

        bool proofResult = s_verifier.verify(proof, inputs);

        emit Panagram__ProofSucceeded(proofResult);

        if (!proofResult) revert Panagram__IncorrectGuess();

        s_lastCorrectGuessRound[msg.sender] = s_currentRound;

        // First round winner: mint nft id 0 otherwise mint nft id 1
        if (s_currentRoundWinner == address(0)) {
            s_currentRoundWinner = msg.sender;
            s_winnerWins[msg.sender]++;
            _mint(msg.sender, 0, 1, "");

            emit Panagram__NFTMinted(msg.sender, 0);
        } else {
            _mint(msg.sender, 1, 1, "");
            emit Panagram__NFTMinted(msg.sender, 1);
        }

        return proofResult;
    }

    function setVerifier(IVerifier _verifier) external onlyOwner {
        s_verifier = _verifier;

        emit Panagram__VerifierUpdated(_verifier);
    }
}
