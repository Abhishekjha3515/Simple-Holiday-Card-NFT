// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleHolidayCardNFT {
    // Struct to represent a holiday card NFT
    struct HolidayCard {
        address owner;
        string message;
        string recipientName;
        string holidayType;
        uint256 timestamp;
    }

    // Array to store all holiday cards
    HolidayCard[] public holidayCards;

    // Mapping to track total cards owned by an address
    mapping(address => uint256[]) public ownerCardIndex;

    // Event for minting a new holiday card
    event CardMinted(
        uint256 indexed cardId, 
        address indexed owner, 
        string recipientName, 
        string holidayType
    );

    // Function to mint a new holiday card
    function mintHolidayCard(
        string memory _message, 
        string memory _recipientName, 
        string memory _holidayType
    ) public returns (uint256) {
        // Validate input parameters
        require(bytes(_message).length > 0, "Message cannot be empty");
        require(bytes(_recipientName).length > 0, "Recipient name cannot be empty");
        require(bytes(_holidayType).length > 0, "Holiday type cannot be empty");

        // Create new holiday card
        HolidayCard memory newCard = HolidayCard({
            owner: msg.sender,
            message: _message,
            recipientName: _recipientName,
            holidayType: _holidayType,
            timestamp: block.timestamp
        });

        // Add card to the array and get its ID
        uint256 cardId = holidayCards.length;
        holidayCards.push(newCard);

        // Track cards owned by this address
        ownerCardIndex[msg.sender].push(cardId);

        // Emit event for the minted card
        emit CardMinted(cardId, msg.sender, _recipientName, _holidayType);

        return cardId;
    }

    // Function to get cards owned by an address
    function getCardsByOwner(address _owner) public view returns (HolidayCard[] memory) {
        uint256[] memory cardIds = ownerCardIndex[_owner];
        HolidayCard[] memory ownedCards = new HolidayCard[](cardIds.length);

        for (uint256 i = 0; i < cardIds.length; i++) {
            ownedCards[i] = holidayCards[cardIds[i]];
        }

        return ownedCards;
    }

    // Function to get total number of holiday cards
    function getTotalCards() public view returns (uint256) {
        return holidayCards.length;
    }
}