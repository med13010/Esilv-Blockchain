pragma solidity ^0.4.0;



contract Ballot {

	address owner=0x004fEf376f2E29f1aF441CA0D64650380b022F89;

    struct Member{

        address name;

        uint numberOfVotes;

        bool proposed;

        uint balance;

    }



    struct Proposal{

        string name;

        address creator;

        string description;

        uint numberOfVotes;

    }



    Proposal[] proposals;

    mapping(address => Member) members;

    uint current_block_number;

    uint deadline;

    

    //@notice Create a new member

    function CreateMember(){

        Member member;

        member.numberOfVotes=0;

        member.proposed=false;

        member.name=msg.sender;

        member.balance=0;

    }



    //@notice create a new proposal if this is possible



    function CreateProposal(string _name, string _descr){

        if (!members[msg.sender].proposed){

            Proposal prop;

            prop.name=_name;

            prop.creator=msg.sender;

            prop.description=_descr;

            prop.numberOfVotes=1;

            if (proposals.length<5){

                proposals.length++;

                proposals[proposals.length-1]=prop;

            }

            if (proposals.length==5){

                deadline = current_block_number + 556070; //A deadline of 1 month

            }

        }

    }



    function addTokenToBalance(uint j){

      members[msg.sender].balance+=j;

    }



    function Vote(uint prop){

        if (members[msg.sender].numberOfVotes>0 && current_block_number<deadline && members[msg.sender].balance>0 && members[msg.sender].name!=proposals[prop].creator){

        proposals[prop].numberOfVotes++;}

    }



    function WinningProposal() returns(string){

        if(current_block_number>deadline){

            uint max=0;

            for (uint i=0;i<proposals.length;i++){

                if (proposals[i].numberOfVotes>proposals[max].numberOfVotes){

                    max=i;

                }

            }

            return proposals[i].name;

        }

        return "No winner yet !";

    }



    function Ballot(){

        current_block_number =block.number;

    }

    

    function kill(){if (msg.sender=owner) selfdestruct(owner); }

}