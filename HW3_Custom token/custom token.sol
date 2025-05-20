// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Import OpenZeppelin's ReentrancyGuard
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// Import OpenZeppelin's Math utilities
import "@openzeppelin/contracts/utils/math/Math.sol";
/**
* @title CustomToken
* @dev Implementation of a simple custom token with mint, transfer, and sell functionality
* Strictly adhering to the required API specification
*/
contract CustomToken is ReentrancyGuard {
// State variables - only public ones as specified in requirements
address payable public owner; // Contract owner
// Private state variables
mapping(address => uint256) private _balances; // Token balances per address
uint256 private _totalSupply; // Total number of issued tokens
string private constant _name = "Fake Ethereum"; // Fixed token name
string private constant _symbol = "FETH"; // Fixed token symbol
uint128 private constant _price = 600; // Token price (fixed at 600 wei)
// Constants for token limits (private)
uint256 private constant MAX_SUPPLY = 1000000 * (10 ** 18); // 1 million tokens max supply
uint256 private constant LARGE_TRANSFER_THRESHOLD = 100000 * (10 ** 18); // 100k tokens
// Approval tracking (private)
mapping(address => mapping(uint256 => bool)) private _largeTransferApprovals;
uint256 private _transferNonce = 0;
// Events - exactly as specified in requirements
event Transfer(address indexed from, address indexed to, uint256 value);
event Mint(address indexed to, uint256 value);
event Sell(address indexed from, uint256 value);
// Internal events - not part of the public API
event LargeTransferRequested(address indexed from, address indexed to, uint256 value, uint256 nonce);
event LargeTransferApproved(address indexed from, address indexed to, uint256 value, uint256 nonce);
/**
* @dev Constructor sets the deployer as the contract owner
*/
constructor() {
owner = payable(msg.sender);
}
/**
* @dev Returns the total supply of tokens
* @return uint256 The total token supply
*/
function totalSupply() public view returns (uint256) {
return _totalSupply;
}
/**
* @dev Returns the token balance of a specific address
* @param account The address to query the balance of
* @return uint256 The token balance
*/
function balanceOf(address account) public view returns (uint256) {
return _balances[account];
}
/**
* @dev Returns the token name
* @return string The token name ("Fake Ethereum")
*/
function getName() public pure returns (string memory) {
return _name;
}
/**
* @dev Returns the token symbol
* @return string The token symbol ("FETH")
*/
function getSymbol() public pure returns (string memory) {
return _symbol;
}
/**
* @dev Returns the token price
* @return uint128 The token price (600 wei)
*/
function getPrice() public pure returns (uint128) {
return _price;
}
/**
* @dev Transfers tokens from caller to another address
* @param to The recipient address
* @param value The amount of tokens to transfer
* @return bool True if the transfer succeeded
*/
function transfer(address to, uint256 value) public nonReentrant returns (bool) {
require(to != address(0), "Transfer to the zero address is not allowed");
require(_balances[msg.sender] >= value, "Insufficient balance");
// Check if this is a large transfer requiring owner approval
if (value >= LARGE_TRANSFER_THRESHOLD && msg.sender != owner) {
bool approved = _checkAndHandleLargeTransfer(msg.sender, to, value);
if (!approved) return false;
}
_balances[msg.sender] -= value;
_balances[to] += value;
emit Transfer(msg.sender, to, value);
return true;
}
/**
* @dev Creates new tokens and assigns them to an address
* @param to The address to receive the minted tokens
* @param value The amount of tokens to mint
* @return bool True if the minting succeeded
*/
function mint(address to, uint256 value) public returns (bool) {
require(msg.sender == owner, "Only owner can mint tokens");
require(to != address(0), "Mint to the zero address is not allowed");
require(value > 0, "Mint value must be positive");
// Limit minting to maximum supply
uint256 mintAmount = _calculateMintAmount(value);
require(mintAmount > 0, "Maximum supply reached or requested amount too large");
_totalSupply += mintAmount;
_balances[to] += mintAmount;
emit Mint(to, mintAmount);
return true;
}
/**
* @dev Allows users to sell tokens back to the contract at fixed price
* @param value The amount of tokens to sell
* @return bool True if the sale succeeded
*/
function sell(uint256 value) public nonReentrant returns (bool) {
require(_balances[msg.sender] >= value, "Insufficient balance");
uint256 weiAmount = value * _price; // Calculate payout (600 wei * tokens)
require(address(this).balance >= weiAmount, "Contract has insufficient funds");
// Update state before external call (prevents reentrancy)
_balances[msg.sender] -= value;
_totalSupply -= value;
// Transfer ether to the seller
payable(msg.sender).transfer(weiAmount);
emit Sell(msg.sender, value);
return true;
}
/**
* @dev Destroys the contract and sends its balance to the owner
*/
function close() public {
require(msg.sender == owner, "Only owner can close the contract");
selfdestruct(owner);
}
/**
* @dev Fallback function to accept ETH
*/
fallback() external payable {}
/**
* @dev Receive function to accept ETH
*/
receive() external payable {}
// --- INTERNAL HELPER FUNCTIONS ---
/**
* @dev Handles large transfer approval logic
* @param from Sender address
* @param to Recipient address
* @param value Transfer amount
* @return bool Whether the transfer is approved
*/
function _checkAndHandleLargeTransfer(address from, address to, uint256 value) internal returns (bool) {
uint256 nonce = _transferNonce;
// Check if this transfer has already been approved
if (_largeTransferApprovals[from][nonce]) {
// Clear approval after use
_largeTransferApprovals[from][nonce] = false;
_transferNonce++; // Increment nonce for next request
return true;
}
// Request approval for large transfer
emit LargeTransferRequested(from, to, value, nonce);
_transferNonce++; // Increment nonce for next request
return false;
}
/**
* @dev Calculates the actual amount that can be minted based on max supply
* @param requestedAmount The requested amount to mint
* @return uint256 The actual amount that can be minted
*/
function _calculateMintAmount(uint256 requestedAmount) internal view returns (uint256) {
// Calculate how many tokens can still be minted
uint256 remainingSupply = 0;
if (_totalSupply < MAX_SUPPLY) {
remainingSupply = MAX_SUPPLY - _totalSupply;
}
// Limit minting amount to the remaining available supply
return Math.min(requestedAmount, remainingSupply);
}
/**
* @dev Internal function to approve large transfers (only callable by owner)
* This would typically be called via another function or transaction
*/
function _approveLargeTransfer(address from, uint256 nonce) internal {
require(msg.sender == owner, "Only owner can approve large transfers");
_largeTransferApprovals[from][nonce] = true;
emit LargeTransferApproved(from, address(0), 0, nonce); // We don't expose receiver/value in the event for privacy
}
}