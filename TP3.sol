pragma solidity ^0.4.0;



contract Ballot {

    address owner=0x004fEf376f2E29f1aF441CA0D64650380b022F89;





    struct Member{

        address name;

        uint numberOfVotes;

        bool voted;

        uint balance; //=number of parts in the company

    }



    struct Proposal{

        bool exist;

        string name;

        address creator;

        string description;

        uint numberOfYes;

    }



    Proposal proposal;

    mapping(address => Member) members;

    uint current_block_number;

    uint deadline;

    uint numberOfMembers =0;

    uint totalBalance=0;

    

    //@notice Create a new member

    function CreateMember(){

        Member member;

        member.numberOfVotes=0;

        member.voted=false;

        member.name=msg.sender;

        member.balance=0;

        numberOfMembers++;

    }



    //@notice create a new proposal if this is possible



    function CreateProposal(string _name, string _descr){

        if (!proposal.exist){

            Proposal prop;

            prop.exist=true;

            prop.name=_name;

            prop.creator=msg.sender;

            prop.description=_descr;

            prop.numberOfYes=0;

            deadline = current_block_number + 556070; //A deadline of 1 month

        }

    }



    function addMoreParts(uint j){

        members[msg.sender].balance+=j;

        totalBalance+=j;

    }



    function Vote(bool vote){

        if (current_block_number<deadline && members[msg.sender].balance>0){

            if (vote)

                proposal.numberOfYes+=members[msg.sender].balance; // vote is proportional to how many parts of the company you own

            //not voting is equivalent to voting NO to the proposal

        }

    }

    function WinningProposal() returns(string){

        if(current_block_number>deadline){

            if (proposal.numberOfYes>totalBalance/2){

                deadline+=99999999999999999999999999999999;

                proposal.exist=false;

                return "Accepted !";

            }

            return "Rejected !";

        }

        return "No decision yet !";

    }



    function Ballot(){

        current_block_number =block.number;

    }

    

    function kill(){if (msg.sender==owner) selfdestruct(owner); }

}