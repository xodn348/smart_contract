# CustomToken (FETH)

A custom ERC-like token called **Fake Ethereum (FETH)**, built in Solidity. Includes minting, transferring, and selling functionality with basic safety features.

## Features

- Minting by contract owner (up to 1 million tokens)
- Token transfer between users
- Owner-approved large transfer requests (≥100k tokens)
- Users can sell tokens back to contract at 600 wei/token
- Uses OpenZeppelin's `ReentrancyGuard` and `Math` utilities

## Functions

- `mint(address to, uint256 value)`: Mint tokens to a user (owner only)
- `transfer(address to, uint256 value)`: Transfer tokens to another user
- `sell(uint256 value)`: Sell tokens back to the contract for ETH
- `totalSupply()` / `balanceOf(address)`: View total supply and user balance
- `close()`: Self-destruct the contract (owner only)

## Notes

- Large transfers (≥100k tokens) require explicit owner approval
- This contract is not fully ERC20-compliant
- Intended for educational or demonstration use only

## Dependencies

- OpenZeppelin Contracts (`@openzeppelin/contracts`)

## Token Details

- Name: Fake Ethereum
- Symbol: FETH
- Price: 600 wei
- Max Supply: 1,000,000 FETH

## License

MIT
