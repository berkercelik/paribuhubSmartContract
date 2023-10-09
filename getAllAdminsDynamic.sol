// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;


contract ParibuHub{

struct Account {
        string name;
        string surname;
        uint256 balance;
    }
    
Account account;
Account[] public admins;


 function addAdmin(string memory _name,string memory _surname, uint256 _balance) public {
        admins.push(Account(_name,_surname,_balance));
}

// indexine gore tek admin listeleme
// list one admin for admin's index
function getOneAdmin(uint256 index) public view returns(string memory, string memory, uint256) {
    require(index<admins.length, "index array");
    Account memory admin= admins[index];
    return (admin.name, admin.surname, admin.balance);
}

// tum adminleri listeleme
// list all admins
function getAllAdmins() public view returns (Account[] memory) {
        Account[] memory _temp = new Account[](admins.length);
        for (uint i = 0; i < admins.length; i++) {
            _temp[i] = admins[i];
        }

        return _temp;
    }

}