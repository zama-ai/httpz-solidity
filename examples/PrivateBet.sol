// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity >=0.8.13 <0.9.0;

import "../lib/TFHE.sol";

import "./abstract/EIP712WithModifier.sol";

import "./EncryptedERC20.sol";

contract PrivateBet is EIP712WithModifier {
    // The owner of the contract.
    address public contractOwner;

    EncryptedERC20 public tokenContract;

    enum BetState {
        PENDING,
        WON,
        LOST
    }

    enum GameState {
        OPEN,
        CLOSED,
        CANCELED
    }

    struct BetReturn {
        bytes amount;
        BetState state;
    }

    struct Bet {
        bool exists;
        euint32 amount;
        BetState state;
    }

    struct Game {
        string description;
        GameState state;
        uint256 numBets;
        bool isSuccessful; // winning option
    }

    // gameId => user => bet
    mapping(uint256 => mapping(address => Bet)) bets;

    Game[] public games;
    uint256 public numGames;
    uint32 public constant BET_MULTIPLIER = 2;

    event NewGame(string description);
    event NewBet(uint256 gameID, euint32 encryptedBetAmount);
    event GameClosed(uint256 gameID, string description, bool isSuccessful);

    constructor(
        EncryptedERC20 _tokenContract
    ) EIP712WithModifier("Authorization token", "1") {
        contractOwner = msg.sender;
        numGames = 0;
        tokenContract = _tokenContract;
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner);
        _;
    }

    function createGame(string memory _description) public onlyContractOwner {
        games.push(
            Game({
                description: _description,
                state: GameState.OPEN,
                numBets: 0,
                isSuccessful: false
            })
        );
        numGames++;
        emit NewGame(_description);
    }

    function placeBet(uint256 _gameId, bytes calldata _encryptedAmount) public {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.state == GameState.OPEN, "Game is not open");
        require(!bets[_gameId][msg.sender].exists, "You already bet");

        euint32 encryptedBetAmount = TFHE.asEuint32(_encryptedAmount);
        tokenContract.transferFrom(
            msg.sender,
            address(this),
            encryptedBetAmount
        );

        bets[_gameId][msg.sender] = Bet(
            true,
            encryptedBetAmount,
            BetState.PENDING
        );

        games[_gameId].numBets++;

        emit NewBet(_gameId, encryptedBetAmount);
    }

    function getBet(
        uint256 gameId,
        bytes32 publicKey,
        bytes calldata signature
    )
        public
        view
        onlySignedPublicKey(publicKey, signature)
        returns (BetReturn memory)
    {
        require(gameId < numGames, "Invalid game ID");
        require(bets[gameId][msg.sender].exists, "No bet for this user");

        Bet storage bet = bets[gameId][msg.sender];

        return
            BetReturn({
                amount: TFHE.reencrypt(bet.amount, publicKey, 0),
                state: bet.state
            });
    }

    function cancelGame(uint256 _gameId) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(
            game.state == GameState.OPEN,
            "Game is already closed or canceled"
        );
        game.state = GameState.CANCELED;
    }

    function closeGame(
        uint256 _gameId,
        bool _isSuccessful
    ) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(
            game.state == GameState.OPEN,
            "Game is already closed or canceled"
        );

        game.state = GameState.CLOSED;
        game.isSuccessful = _isSuccessful;

        emit GameClosed(_gameId, games[_gameId].description, _isSuccessful);
    }

    function withdraw(uint256 _gameId) public {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(!(game.state == GameState.OPEN), "Game is not yet closed");
        Bet storage bet = bets[_gameId][msg.sender];
        require(bet.state == BetState.PENDING, "Bet already processed");

        if (game.state == GameState.CANCELED) {
            // No results, so the bet has been canceled
            bet.state = BetState.WON;
            tokenContract.transfer(msg.sender, bet.amount);
        } else if (game.isSuccessful) {
            bet.state = BetState.WON;
            tokenContract.transfer(
                msg.sender,
                TFHE.mul(BET_MULTIPLIER, bet.amount)
            );
        } else {
            bet.state = BetState.LOST;
        }
    }
}
