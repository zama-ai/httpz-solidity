// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity >=0.8.13 <0.9.0;

import "../lib/TFHE.sol";

contract PrivateBetting {
    // The owner of the contract.
    address internal contractOwner;

    EncryptedToken encryptedToken;
    
    enum BetState {PENDING, WON, LOST}
    
    struct Bet {
        address user;
        uint256 gameId;
        euint32 amount;
        uint256 betOption; // User bets on this outcome option (0 => team A wins, 1 => team B wins, etc.)
        BetState state;
    }
    
    struct Game {
        string description;
        bool isOpen;
        bool winningsDistributed;
        uint256 numBets;
        uint256 maxBetOptions;
    }

    Bet[] bets;

    Game[] public games;
    uint256 public numGames;
    uint32 constant public BET_MULTIPLIER = 2;
    
    event NewGame(string description);
    event NewBet(uint256 gameID, uint256 betOption, euint32 encryptedBetAmount);
    event GameClosed(uint256 gameID, string description);

    constructor(address _encryptedToken) {
        numGames = 0;
        encryptedToken = EncryptedToken(_encryptedToken);
    }
    
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner);
        _;
    }
    
    function createGame(string memory _description, uint256 _maxBetOptions) public onlyContractOwner {
        games.push(Game(_description, true, false, 0, _maxBetOptions));
        numGames++;
        emit NewGame(_description);
    }
    
    function placeBet(uint256 _gameId, uint256 _betOption, uint32 _encryptedAmount) public {
    // function placeBet(uint256 _gameId, uint256 _betOption, bytes calldata _encryptedAmount) public {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.isOpen, "Game is not open");
        require(_betOption < game.maxBetOptions, "Invalid option");

        euint32 encryptedBetAmount = TFHE.asEuint32(_encryptedAmount);
        encryptedToken.transferFrom(msg.sender, address(this), encryptedBetAmount);

        bets.push(
            Bet(
                msg.sender,
                _gameId,
                encryptedBetAmount,
                _betOption,
                BetState.PENDING
            )
        );

        emit NewBet(_gameId, _betOption, encryptedBetAmount);
    }
    
    function closeGame(uint256 _gameId) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.isOpen, "Game is already closed");
        game.isOpen = false;
        emit GameClosed(_gameId, games[_gameId].description);
    }

    function distributeWinnings(uint256 _gameId, bool[] calldata _betResults) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(!game.isOpen, "Game is not yet closed");
        require(_betResults.length == game.maxBetOptions, "Results for every option must be provided");
        require(!game.winningsDistributed, "Winnings already distributed for this game");


        for (uint i = 0; i < bets.length; i++) {
            Bet storage bet = bets[i];

            if (bet.gameId == _gameId) { // fait à la va-vite :^)
                if (_betResults[bet.betOption]) { 
                    bet.state = BetState.WON;
                    encryptedToken.transfer(bet.user, TFHE.mul(BET_MULTIPLIER, bet.amount));
                } else {
                    bet.state = BetState.LOST;
                }
            }
        }
        game.winningsDistributed = true;
    }
}

interface EncryptedToken {
    function transfer(address to, euint32 amount) external;
    function transferFrom(address from, address to, euint32 amount) external;
}
