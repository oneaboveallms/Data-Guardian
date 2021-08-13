pragma solidity >=0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        string party;
        string constituency;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Narendra Modi","Bharatiya Janata Party","Bareilly");
        addCandidate("Rahul Gandhi","Indian National Congress","Jhansi");
        addCandidate("Mamta Banerjee","All India Trinamool Congress","Badaun");
        addCandidate("Mayavati","Bahujan Samaj Party","Rampur");
    }

    function addCandidate (string memory name,string memory party,string memory constituency) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, name,party,constituency, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}