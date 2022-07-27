// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Voting {
    address public admin;
    Candidate[2] public candidates;
    mapping(address => Voter) public voters;
    bool public isActive;

    struct Voter {
        bool voted;
        bool canVote;
    }

    struct Candidate {
        string name;
        uint voteCount;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "You are not the admin.");
        _;
    }

    constructor (string memory _candidate1, string memory _candidate2) {
        admin = msg.sender;
        isActive = true;
        candidates[0] = Candidate({
            name: _candidate1,
            voteCount: 0
        });
        candidates[1] = Candidate({
            name: _candidate2,
            voteCount: 0
        });
    }

    function vote (uint _candidateToVote) public returns (bool) {
        require(isActive, "Voting is closed.");
        Voter storage sender = voters[msg.sender];
        require(sender.canVote,"You cannot vote.");
        require(!sender.voted,"You already voted.");
        require(_candidateToVote < 2, "Invalid candidate.");
        candidates[_candidateToVote].voteCount++;
        sender.voted = true;
        return true;
    }

    function giveRightToVote(address _voter) public onlyAdmin {
        require(!voters[_voter].voted, "You already voted.");
        voters[_voter].canVote = true;
    }

    function endVoteContract() public onlyAdmin {
        isActive = false;
    }

    function getWinningName() public view  returns (string memory) {
        require(!isActive, "Voting is open.");
        if (candidates[0].voteCount > candidates[1].voteCount) {
            return candidates[0].name;
        } else {
            return candidates[1].name;
        }
    }
}
