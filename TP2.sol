pragma solidity ^0.4.0;



contract Fidelity {

    address owner=0x004fEf376f2E29f1aF441CA0D64650380b022F89;


    struct Account {

        address owner;

        uint numberOfFidelityPoints;

        address[] nephews;

        address[] sponsors;

    }

    

    mapping(address=>Account) accounts;

    

    function CreateAccount(){

        Account account;

        account.owner=msg.sender;

        account.numberOfFidelityPoints=0;

        accounts[msg.sender]=account;

    }

    

    function Sponsor(address nephew) returns(bool){

        if (accounts[nephew].sponsors.length<2 && accounts[nephew].sponsors[0]!=msg.sender){

            accounts[nephew].sponsors[accounts[nephew].sponsors.length]=msg.sender;

            accounts[nephew].numberOfFidelityPoints+=10;

            accounts[msg.sender].nephews[accounts[msg.sender].nephews.length]=nephew;

            accounts[msg.sender].numberOfFidelityPoints+=10;

            return true;

        }

        return false;

    }

    

    

    

    function Fidelity(){}

    function kill(){if (msg.sender=owner) selfdestruct(owner); }

}