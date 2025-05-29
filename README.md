# Smart Contract Projects

This repository contains a series of smart contracts developed and deployed using Solidity, covering fundamental concepts such as Ether handling, cryptographic commitments, and custom token logic. All contracts were tested using Remix IDE and deployed to Ethereum public testnets.

## Projects Overview

### 1. Bank Contract (Basic ETH Logic)

**Folder:** `HW1_Build smart contract`  
A simple Ethereum-based bank system that allows users to:
- Deposit Ether with a message (with a flat fee)
- Withdraw their personal balance
- Allow the first depositor to empty the contract
- Emit `Deposit` and `Withdrawal` events

Focus: ETH transfer logic, contract state management, event handling

---

### 2. Matching Pennies Game

**Folder:** `HW2_Matching Pennies`  
A two-player on-chain game with the following features:
- Commitment scheme using hash values to hide player choices
- Secure reveal and outcome resolution logic
- Timeout handling if one player doesn't respond
- Ether reward transfer based on game outcome

Focus: Commitment schemes, fairness in smart contracts, game logic design

---

### 3. Custom Token Contract (ERC20-like)

**Folder:** `HW3_Custom token`  
A fully functional custom token contract with:
- Minting (owner-only, up to 1,000,000 tokens)
- Token transfer with large transfer approval system
- Token selling at a fixed price (600 wei/token)
- OpenZeppelin `ReentrancyGuard` and `Math` integration
- Event emission for mint, transfer, and sell actions

Focus: Token economics, security best practices, OpenZeppelin integration

---

## Tools & Environment

- **Language:** Solidity (`^0.8.0`)
- **IDE:** Remix
- **Deployment:** Ethereum Testnet (via MetaMask)
- **Libraries:** OpenZeppelin Contracts

## License

This repository is licensed under the MIT License.
