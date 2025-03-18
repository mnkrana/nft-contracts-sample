// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "./openzeppelin/access/Ownable.sol";
import "./openzeppelin/token/ERC1155/ERC1155.sol";
import "./openzeppelin/token/ERC1155/extensions/ERC1155Pausable.sol";
import "./openzeppelin/token/ERC1155/extensions/ERC1155Burnable.sol";
import "./openzeppelin/token/ERC1155/extensions/ERC1155Supply.sol";

contract Rana is
    ERC1155,
    Ownable,
    ERC1155Pausable,
    ERC1155Burnable,
    ERC1155Supply
{
    mapping(uint256 => string) private _uris;
    string private contractUri;

    constructor(
        address initialOwner,
        string memory uri_
    ) ERC1155("") Ownable(initialOwner) {
        contractUri = uri_;
    }

    function contractURI() public view returns (string memory) {
        return contractUri;
    }

    function updateInitialUri(string memory uri_) public onlyOwner {
        contractUri = uri_;
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        return (_uris[tokenId]);
    }

    function setTokenUri(
        uint256 id,
        string memory uri_
    ) public onlyOwner whenNotPaused {
        _uris[id] = uri_;
        emit URI(uri_, id);
    }

    function setTokenUriBatch(
        uint256[] memory ids,
        string[] memory uris_
    ) public onlyOwner whenNotPaused {
        require(
            ids.length == uris_.length,
            "length of id array is different than of uri array."
        );

        for (uint256 i = 0; i < uris_.length; i++) {
            setTokenUri(ids[i], uris_[i]);
        }
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        string memory uri_
    ) public onlyOwner whenNotPaused {
        _mint(account, id, amount, "");
        setTokenUri(id, uri_);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        string[] memory uris_
    ) public onlyOwner whenNotPaused {
        _mintBatch(to, ids, amounts, "");
        setTokenUriBatch(ids, uris_);
    }
    
    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._update(from, to, ids, values);
    }
}
