// SPDX-License-Identifier: GPL-3.0

//address = 0xc74E965A03A30d9351812e411C537c8033BBB43D

pragma solidity >=0.7.0 <0.9.0;

contract Messenger {
    mapping(address => address[]) public allContacts;

    mapping(address => bool) public isInContact;

    function addContact(address addressToBeAdded) public payable {
        require(
            msg.sender != addressToBeAdded,
            "You cannot add your own address"
        );
        require(!isInContact[addressToBeAdded], "Contact already added");

        allContacts[msg.sender].push(addressToBeAdded);
        allContacts[addressToBeAdded].push(msg.sender); //both side the address is added

        isInContact[addressToBeAdded] = true;
    }

    function showContacts(
        address showContactsOf
    ) public view returns (address[] memory) {
        require(
            allContacts[showContactsOf].length != 0,
            "Currently there are no contacts"
        );
        return allContacts[showContactsOf];
    }

    struct Message {
        string _msg;
        address _address;
    }

    mapping(address => Message[]) chats;

    function showMsgsOf(
        address showChatsWith
    ) public view returns (Message[] memory) {
        return chats[showChatsWith];
    }

    function sendMsgTo(address _to, string memory _msg) public payable{
        chats[_to].push(Message(_msg, msg.sender));
        chats[msg.sender].push(Message(_msg, _to)); //msg added to both sides
    }
}
