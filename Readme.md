# Simple Holiday Card NFT

A simple decentralized application (dApp) that allows users to mint, view, and store holiday card NFTs on the Ethereum blockchain. This project uses a smart contract to mint unique holiday cards with messages, recipient names, and holiday types.

## Features

- **Mint Holiday Cards**: Users can mint new holiday card NFTs with a personalized message, recipient name, and holiday type.
- **View Your Cards**: Users can view all holiday cards they've minted.
- **Total Cards**: Displays the total number of holiday cards minted on the Ethereum network.
- **Immutable & Decentralized**: All holiday cards are stored on the Ethereum blockchain, ensuring the data is secure and transparent.

---

## Prerequisites

To run the project, make sure you have the following tools and accounts set up:

1. **MetaMask** (or any Web3 wallet) installed in your browser.
2. **Ethereum Testnet** or **Mainnet** configured in MetaMask (e.g., Goerli, Rinkeby, or Mainnet).
3. **Web3.js** for interacting with the Ethereum blockchain.
4. **Node.js** and **npm** (if you want to run the project locally).
5. **Solidity** basic knowledge for smart contract interactions.

---

## Installation

### 1. Deploy the Smart Contract

The smart contract `SimpleHolidayCardNFT.sol` is written in Solidity and should be deployed to an Ethereum testnet or the mainnet.

1. **Deploy the contract** using [Remix IDE](https://remix.ethereum.org/).
   - Open Remix, paste the Solidity code into a new file, and compile it.
   - Deploy the contract on a test network like **Goerli** or **Rinkeby** (or the mainnet if you're ready).
   - **Save the contract address and ABI**, as you'll need them to interact with the frontend.

### 2. Set Up the Frontend

1. **Clone or Download the Repository**:

   ```bash
   git clone <repository-url>
   cd SimpleHolidayCardNFT
   ```

2. **Modify the Frontend Code**:

   - Open `index.html` in a text editor and replace the following placeholders:
     - **`YOUR_CONTRACT_ADDRESS`**: Replace this with your deployed contract address.
     - **`contractABI`**: Replace this with the ABI of your deployed contract.

   Example:

   ```javascript
   const contractAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with your deployed contract address
   const contractABI = [
       // Replace with the ABI of your deployed contract
       ...
   ];
   ```

### 3. Host the Frontend

You can serve the `index.html` file locally or deploy it using hosting platforms like:

- **GitHub Pages**
- **Netlify**
- **Vercel**

If you choose to run it locally:

1. Open the `index.html` file in your browser.
2. Ensure that your MetaMask wallet is connected and set to the appropriate network where your contract is deployed.

---

## How It Works

### 1. **Smart Contract:**

The `SimpleHolidayCardNFT` contract stores holiday cards as NFTs on the blockchain. Each card is associated with the following data:

- **Owner**: The address of the user who owns the card.
- **Message**: The message written on the holiday card.
- **Recipient Name**: The recipient of the holiday card.
- **Holiday Type**: The type of holiday (e.g., Christmas, New Year).
- **Timestamp**: The timestamp when the card was minted.

The contract allows users to:

- **Mint a new card**: Add a new card to the blockchain with a message, recipient name, and holiday type.
- **Get cards by owner**: Retrieve all cards owned by a particular address.
- **Get total cards**: Retrieve the total number of cards minted.

### 2. **Frontend:**

The frontend is built with HTML, CSS, and JavaScript. It uses **Web3.js** to interact with the Ethereum blockchain through MetaMask.

The key features of the frontend include:

- **Mint a Holiday Card**: Users can input a message, recipient name, and holiday type to mint a new card.
- **View Your Cards**: Users can view all cards they have minted by fetching them from the blockchain.
- **Total Cards**: The total number of holiday cards minted can be displayed.

---

## Usage

1. **Connect Your Wallet**:

   - Click the **"Connect Wallet"** button to connect your MetaMask wallet to the dApp. Once connected, your Ethereum address will be displayed.

2. **Mint a New Holiday Card**:

   - Enter a personalized **message**, **recipient name**, and **holiday type**.
   - Click **"Mint Holiday Card"** to mint a new card on the blockchain. This will require a gas fee paid via MetaMask.

3. **View Your Holiday Cards**:

   - After minting, click **"View Your Cards"** to see a list of all holiday cards that you own.
   - Each card will display the recipient's name, holiday type, message, and the timestamp when it was minted.

4. **View Total Cards Minted**:
   - The **total number of holiday cards** minted is displayed on the page.

---

## Contract Code (`SimpleHolidayCardNFT.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleHolidayCardNFT {
    struct HolidayCard {
        address owner;
        string message;
        string recipientName;
        string holidayType;
        uint256 timestamp;
    }

    HolidayCard[] public holidayCards;
    mapping(address => uint256[]) public ownerCardIndex;

    event CardMinted(uint256 indexed cardId, address indexed owner, string recipientName, string holidayType);

    function mintHolidayCard(string memory _message, string memory _recipientName, string memory _holidayType) public returns (uint256) {
        require(bytes(_message).length > 0, "Message cannot be empty");
        require(bytes(_recipientName).length > 0, "Recipient name cannot be empty");
        require(bytes(_holidayType).length > 0, "Holiday type cannot be empty");

        HolidayCard memory newCard = HolidayCard({
            owner: msg.sender,
            message: _message,
            recipientName: _recipientName,
            holidayType: _holidayType,
            timestamp: block.timestamp
        });

        uint256 cardId = holidayCards.length;
        holidayCards.push(newCard);
        ownerCardIndex[msg.sender].push(cardId);

        emit CardMinted(cardId, msg.sender, _recipientName, _holidayType);

        return cardId;
    }

    function getCardsByOwner(address _owner) public view returns (HolidayCard[] memory) {
        uint256[] memory cardIds = ownerCardIndex[_owner];
        HolidayCard[] memory ownedCards = new HolidayCard[](cardIds.length);

        for (uint256 i = 0; i < cardIds.length; i++) {
            ownedCards[i] = holidayCards[cardIds[i]];
        }

        return ownedCards;
    }

    function getTotalCards() public view returns (uint256) {
        return holidayCards.length;
    }
}
```

---

## Troubleshooting

- **MetaMask Issues**: Ensure MetaMask is properly configured and connected to the correct network (same one where the contract is deployed).
- **Transaction Failed**: Make sure your MetaMask wallet has enough ETH to cover gas fees.
- **Cards Not Displaying**: Verify that the contract address and ABI are correctly placed in the frontend JavaScript file.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
