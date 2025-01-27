// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable(msg.sender) {
string private salt = "jashaine";
struct Contact {
uint id;
string firstName;
string lastName;
uint[] phoneNumbers;
}

Contact[] private contacts;
mapping(uint => uint) private idToIndex;
uint private nextId = 1;

error ContactNotFound(uint id);

function addContact(string calldata firstName, string calldata lastName, uint[] calldata phoneNumbers) external onlyOwner {
contacts.push(Contact(nextId, firstName, lastName, phoneNumbers));
idToIndex[nextId] = contacts.length - 1;
nextId++;
}

function deleteContact(uint id) external onlyOwner {
uint index = idToIndex[id];
if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);

contacts[index] = contacts[contacts.length - 1];
idToIndex[contacts[index].id] = index;
contacts.pop();
delete idToIndex[id];
}

function getContact(uint id) external view returns (Contact memory) {
uint index = idToIndex[id];
if (index >= contacts.length || contacts[index].id != id) revert ContactNotFound(id);
return contacts[index];
}

function getAllContacts() external view returns (Contact[] memory) {
return contacts;
}
}
