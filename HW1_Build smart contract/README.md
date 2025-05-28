# Bank Smart Contract

A simple Ethereum smart contract that simulates a shared bank account system.

## Features

- Users can deposit ETH (10 wei fee per deposit)
- Users can withdraw their full balance anytime
- First depositor can empty the contract balance
- Emits events for deposit and withdrawal

## Functions

- `deposit(string message) payable`: Deposit ETH with a message
- `withdraw()`: Withdraw your full balance
- `getBalance() view`: Check your balance
- `empty()`: First depositor can withdraw all funds

## Notes

- No reentrancy protection (educational use only)
- No duplicate check in `customers` array
- All transactions are public and transparent

## License

GPL-3.0
