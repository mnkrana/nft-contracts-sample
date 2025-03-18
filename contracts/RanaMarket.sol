// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract RanaMarket is Ownable2Step, ReentrancyGuard {
    mapping(uint8 => bool) public isNftSold;
    mapping(uint8 => address) public buyers;

    uint256 public nftPrice;

    event NftPriceUpdated(uint256 amount);
    event NFTBought(address indexed user, uint8 tokenId);
    event TokensWithdrawn(address indexed token, uint256 amount);

    error InvalidAddress();    
    error InvalidAmount();
    error NftAlreadySold(uint8 tokenId);
    error InsufficientBalance();
    error WithdrawFailed();

    constructor(uint256 _nftPrice) Ownable(msg.sender) {
        if (_nftPrice == 0) revert InvalidAmount();
        nftPrice = _nftPrice;
    }

    function updateNFTPrice(uint256 _nftPrice) external onlyOwner {
        if (_nftPrice == 0) revert InvalidAmount();
        nftPrice = _nftPrice;
        emit NftPriceUpdated(_nftPrice);
    }

    function purchase(uint8 _tokenId) external payable nonReentrant {        
        if (msg.value < nftPrice) revert InsufficientBalance();
        if (isNftSold[_tokenId]) revert NftAlreadySold(_tokenId);
        buyers[_tokenId] = msg.sender;        
        isNftSold[_tokenId] = true;
        emit NFTBought(msg.sender, _tokenId);
    }

    function withdrawTokens(address _to, uint256 _amount) external onlyOwner nonReentrant {
        if (_to == address(0)) revert InvalidAddress();
        if (_amount == 0) revert InvalidAmount();
        if (address(this).balance < _amount) revert InsufficientBalance();

        (bool success, ) = _to.call{ value: _amount }("");
        if (!success) revert WithdrawFailed();

        emit TokensWithdrawn(_to, _amount);
    }    
}
