// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract DocumentSignature {

    constructor() payable {

    }

    address[] whitelist;
    mapping(address => bool) signatures;
    string documentHash;
    bool documentSigned = false;

    // Добавление адресов в белый список
    function addToWhitelist(address[] memory addressesToAdd) public {
        for (uint i = 0; i < addressesToAdd.length; i++) {
            whitelist.push(addressesToAdd[i]);
        }
    }

    // Получение текущего белого списка
    function getWhitelist() public view returns (address[] memory) {
        return whitelist;
    }

    // Подписание документа
    function signDocument() public {
        require(isAddressWhitelisted(msg.sender), "Address not whitelisted");
        require(!hasSignedDocument(msg.sender), "Address has already signed the document");

        signatures[msg.sender] = true;

        if (areAllSignaturesCollected()) {
            documentSigned = true;
        }
    }

    // Проверка, что адрес находится в белом списке
    function isAddressWhitelisted(address addressToCheck) public view returns (bool) {
        for (uint i = 0; i < whitelist.length; i++) {
            if (whitelist[i] == addressToCheck) {
                return true;
            }
        }

        return false;
    }

    // Проверка, что адрес уже подписал документ
    function hasSignedDocument(address addressToCheck) public view returns (bool) {
        return signatures[addressToCheck];
    }

    // Проверка, что все адреса из белого списка подписали документ
    function areAllSignaturesCollected() public view returns (bool) {
        for (uint i = 0; i < whitelist.length; i++) {
            if (!signatures[whitelist[i]]) {
                return false;
            }
        }

        return true;
    }

    // Проверка, что документ был подписан всеми адресами из белого списка
    function isDocumentSigned() public view returns (bool) {
        return documentSigned;
    }

    // Установка хэша документа
    function setDocumentHash(string memory hash) public {
        documentHash = hash;
    }

    // Получение хэша документа
    function getDocumentHash() public view returns (string memory) {
        return documentHash;
    }

}
