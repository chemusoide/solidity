// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Constructor: pasa el nombre y el símbolo del token a ERC721 y asigna el propietario inicial a Ownable
    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}

    // Función para acuñar nuevos tokens
    function mintNFT(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
        _setTokenURI(tokenId, uri);  // Asocia la URL de IPFS con el tokenId
    }
}