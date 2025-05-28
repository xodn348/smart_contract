# CustomToken (FETH)

A custom token contract named **Fake Ethereum (FETH)** implemented in Solidity. Provides controlled minting, standard transfers, owner-approved large transfers, and token-to-ETH selling functionality.

## Features

- Only owner can mint tokens (up to 1,000,000 max supply)
- Users can transfer tokens freely
- Large transfers (≥100,000 tokens) require owner approval
- Users can sell tokens back to the contract at 600 wei/token
- Ether support via fallback and receive functions
- Built-in protection with OpenZeppelin's ReentrancyGuard and Math

## Main Functions

- `mint(address to, uint256 value)`: Mint tokens (owner only)
- `transfer(address to, uint256 value)`: Transfer tokens (with large transfer check)
- `sell(uint256 value)`: Sell tokens back for ETH
- `totalSupply()`, `balanceOf(address)`: View supply or balance
- `getName()`, `getSymbol()`, `getPrice()`: Get token details
- `close()`: Destroy contract (owner only)

## Token Parameters

- Name: Fake Ethereum
- Symbol: FETH
- Price: 600 wei per token
- Max Supply: 1,000,000 tokens (18 decimals)
- Large Transfer Threshold: 100,000 tokens

## Notes

- Not ERC20 standard-compliant
- Intended for demonstration or educational use
- Large transfers require approval per nonce (emits request event)
- Uses private internal approval tracking and nonce system

## Dependencies

- OpenZeppelin Contracts
  - `@openzeppelin/contracts/security/ReentrancyGuard.sol`
  - `@openzeppelin/contracts/utils/math/Math.sol`

## License

MIT
