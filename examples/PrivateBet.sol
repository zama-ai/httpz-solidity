// SPDX-License-Identifier: BSD-3-Clause-Clear

pragma solidity >=0.8.13 <0.9.0;

import "../lib/TFHE.sol";

import "./abstract/EIP712WithModifier.sol";

import "./EncryptedERC20.sol";

contract PrivateBet is EIP712WithModifier {
    uint8 constant MAX_OPTION = 2;
    uint8 constant NO_WINNING_OPTION = 11;

    // The owner of the contract.
    address public contractOwner;

    EncryptedERC20 public tokenContract;

    enum BetState {
        PENDING,
        WON,
        LOST
    }

    struct BetReturn {
        bytes amount;
        uint256 option; // User bets on this outcome option (0 => team A wins, 1 => team B wins, etc.)
        BetState state;
    }

    struct Bet {
        bool exists;
        euint32 amount;
        uint8 option; // User bets on this outcome option (0 => team A wins, 1 => team B wins, etc.)
        BetState state;
    }

    struct Game {
        string description;
        bool isOpen;
        uint256 numBets;
        string option1;
        string option2;
        uint8 winningOption; // winning option
    }

    // gameId => user => bet
    mapping(uint256 => mapping(address => Bet)) bets;

    Game[] public games;
    uint256 public numGames;
    uint32 public constant BET_MULTIPLIER = 2;

    event NewGame(string description);
    event NewBet(uint256 gameID, uint256 betOption, euint32 encryptedBetAmount);
    event GameClosed(uint256 gameID, string description, uint8 winningOption);

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

    function createGame(
        string memory _description,
        string memory option1,
        string memory option2
    ) public onlyContractOwner {
        games.push(
            Game({
                description: _description,
                isOpen: true,
                numBets: 0,
                option1: option1,
                option2: option2,
                winningOption: NO_WINNING_OPTION
            })
        );
        numGames++;
        emit NewGame(_description);
    }

    function placeBet(
        uint256 _gameId,
        uint8 _betOption,
        bytes calldata _encryptedAmount
    ) public {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.isOpen, "Game is not open");
        require(_betOption < MAX_OPTION, "Invalid option");
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
            _betOption,
            BetState.PENDING
        );

        games[_gameId].numBets++;

        emit NewBet(_gameId, _betOption, encryptedBetAmount);
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
                option: bet.option,
                state: bet.state
            });
    }

    function cancelGame(uint256 _gameId) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.isOpen, "Game is already closed");
        game.isOpen = false;
    }

    function closeGame(
        uint256 _gameId,
        uint8 winningOption
    ) public onlyContractOwner {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(game.isOpen, "Game is already closed");

        game.isOpen = false;
        game.winningOption = winningOption;

        emit GameClosed(_gameId, games[_gameId].description, winningOption);
    }

    function withdraw(uint256 _gameId) public {
        require(_gameId < numGames, "Invalid game ID");
        Game storage game = games[_gameId];
        require(!game.isOpen, "Game is not yet closed");
        Bet storage bet = bets[_gameId][msg.sender];
        require(bet.state == BetState.PENDING, "Bet already processed");

        if (game.winningOption == NO_WINNING_OPTION) {
            // No results, so the bet has been canceled
            bet.state = BetState.WON;
            tokenContract.transfer(msg.sender, bet.amount);
        } else if (game.winningOption == bet.option) {
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
