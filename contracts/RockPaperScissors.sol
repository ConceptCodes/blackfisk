// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/** 
    @title This is a smart contract to represent the game of Rock paper Scissors
*/
contract RockPaperScissors {
    uint constant public BET_MIN = .25 ether; // The minimum bet  
    uint constant public REVEAL_TIMEOUT = 5 minutes; // Max delay to reveal hand
    // Bet of player 1 
    // uint public initialBet;  
    uint public initialBet;
    uint private firstReveal;  // Moment of first reveal                          

    enum Moves { None, Rock, Paper, Scissors }
     // Possible outcomes
    enum Outcomes { None, PlayerA, PlayerB, Draw }  

    // Players' addresses
    address payable playerA;
    address payable playerB;

    // Encrypted moves
    bytes32 private encrMovePlayerA;
    bytes32 private encrMovePlayerB;

    // Clear moves set only after both players have committed their encrypted moves
    Moves private movePlayerA;
    Moves private movePlayerB;


    modifier validBet() {
        //Bet must be greater than a minimum amount
        require(msg.value >= BET_MIN); 
        require(initialBet == 0 || msg.value >= initialBet); // and greater than bet of first player
        _;
    }

    modifier notAlreadyRegistered() {
        require(msg.sender != playerA && msg.sender != playerB);
        _;
    }

    // Return player's ID upon successful registration.
    function register() public payable validBet notAlreadyRegistered returns (uint) {
        if (playerA == address(0x0)) {
            playerA    = msg.sender;
            initialBet = msg.value;
            return 1;
        } else if (playerB == address(0x0)) {
            playerB = msg.sender;
            return 2;
        }
        return 0;
    }

        modifier isRegistered() {
        require (msg.sender == playerA || msg.sender == playerB);
        _;
    }

    // Save player's encrypted move.
    // Return 'true' if move was valid, 'false' otherwise.
    function play(bytes32 encrMove) public isRegistered returns (bool) {
        if (msg.sender == playerA && encrMovePlayerA == 0x0) {
            encrMovePlayerA = encrMove;
        } else if (msg.sender == playerB && encrMovePlayerB == 0x0) {
            encrMovePlayerB = encrMove;
        } else {
            return false;
        }
        return true;
    }


    modifier commitPhaseEnded() {
        require(encrMovePlayerA != 0x0 && encrMovePlayerB != 0x0);
        _;
    }

    // Compare clear move given by the player with saved encrypted move.
    // Return clear move upon success, 'Moves.None' otherwise.
    function reveal(string memory clearMove) public isRegistered commitPhaseEnded returns (Moves) {
        bytes32 encrMove = sha256(abi.encodePacked(clearMove));  // Hash of clear input (= "move-password")
        Moves move       = Moves(getFirstChar(clearMove));       // Actual move (Rock / Paper / Scissors)

        // If move invalid, exit
        if (move == Moves.None) {
            return Moves.None;
        }

        // If hashes match, clear move is saved
        if (msg.sender == playerA && encrMove == encrMovePlayerA) {
            movePlayerA = move;
        } else if (msg.sender == playerB && encrMove == encrMovePlayerB) {
            movePlayerB = move;
        } else {
            return Moves.None;
        }

        // Timer starts after first revelation from one of the player
        if (firstReveal == 0) {
            firstReveal = now;
        }

        return move;
    }

    // Return first character of a given string.
    function getFirstChar(string memory str) private pure returns (uint) {
        byte firstByte = bytes(str)[0];
        if (firstByte == 0x31) {
            return 1;
        } else if (firstByte == 0x32) {
            return 2;
        } else if (firstByte == 0x33) {
            return 3;
        } else {
            return 0;
        }
    }

    modifier revealPhaseEnded() {
        require((movePlayerA != Moves.None && movePlayerB != Moves.None) ||
                (firstReveal != 0 && now > firstReveal + REVEAL_TIMEOUT));
        _;
    }

    // Compute the outcome and pay the winner(s).
    // Return the outcome.
    function getOutcome() public revealPhaseEnded returns (Outcomes) {
        Outcomes outcome;

        if (movePlayerA == movePlayerB) {
            outcome = Outcomes.Draw;
        } else if ((movePlayerA == Moves.Rock     && movePlayerB == Moves.Scissors) ||
                   (movePlayerA == Moves.Paper    && movePlayerB == Moves.Rock)     ||
                   (movePlayerA == Moves.Scissors && movePlayerB == Moves.Paper)    ||
                   (movePlayerA != Moves.None     && movePlayerB == Moves.None)) {
            outcome = Outcomes.PlayerA;
        } else {
            outcome = Outcomes.PlayerB;
        }

        address payable addrA = playerA;
        address payable addrB = playerB;
        uint betPlayerA       = initialBet;
        reset();  // Reset game before paying to avoid reentrancy attacks
        pay(addrA, addrB, betPlayerA, outcome);

        return outcome;
    }

    // Pay the winner(s).
    function pay(address payable addrA, address payable addrB, uint betPlayerA, Outcomes outcome) private {
        // Uncomment lines below if you need to adjust the gas limit
        if (outcome == Outcomes.PlayerA) {
            addrA.transfer(address(this).balance);
            // addrA.call.value(address(this).balance).gas(1000000)("");
        } else if (outcome == Outcomes.PlayerB) {
            addrB.transfer(address(this).balance);
            // addrB.call.value(address(this).balance).gas(1000000)("");
        } else {
            addrA.transfer(betPlayerA);
            addrB.transfer(address(this).balance);
            // addrA.call.value(betPlayerA).gas(1000000)("");
            // addrB.call.value(address(this).balance).gas(1000000)("");
        }
    }

    // Reset the game.
    function reset() private {
        initialBet      = 0;
        firstReveal     = 0;
        playerA         = address(0x0);
        playerB         = address(0x0);
        encrMovePlayerA = 0x0;
        encrMovePlayerB = 0x0;
        movePlayerA     = Moves.None;
        movePlayerB     = Moves.None;
    }
        // Return contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Return player's ID
    function whoAmI() public view returns (uint) {
        if (msg.sender == playerA) {
            return 1;
        } else if (msg.sender == playerB) {
            return 2;
        } else {
            return 0;
        }
    }

    // Return 'true' if both players have commited a move, 'false' otherwise.
    function bothPlayed() public view returns (bool) {
        return (encrMovePlayerA != 0x0 && encrMovePlayerB != 0x0);
    }

    // Return 'true' if both players have revealed their move, 'false' otherwise.
    function bothRevealed() public view returns (bool) {
        return (movePlayerA != Moves.None && movePlayerB != Moves.None);
    }

    // Return time left before the end of the revelation phase.
    function revealTimeLeft() public view returns (int) {
        if (firstReveal != 0) {
            return int((firstReveal + REVEAL_TIMEOUT) - now);
        }
        return int(REVEAL_TIMEOUT);
    }
}