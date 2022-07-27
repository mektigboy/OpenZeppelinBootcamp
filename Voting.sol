// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Voting {
    // State variables:
    struct Voter{
        bool voted;
        bool canVote;
    }

    mapping(address => Voter) public voters;

    struct Candidate{
        string name;
        uint voteCount;
    }

    Candidate[2] public candidates;
    bool public isActive;
    address public admin;

    // Modifiers:
    modifier onlyAdmin(){
        // Only the admin of the contract can call the function.
        require(msg.sender == admin, "You are not the admin.");
        _;
    }

    // Constructor:
    constructor(string memory _candidate1, string memory _candidate2){
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

    // Functions:

    function vote (uint _candidateToVote) public returns(bool){
        require(isActive, "Voting is closed.");
        Voter storage sender =  voters[msg.sender];
        require(sender.canVote,"You cannot vote.");
        require(!sender.voted,"You cannot vote.");
        require(_candidateToVote < 2, "Invalid candidate.");
        candidates[_candidateToVote].voteCount ++;
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
}
