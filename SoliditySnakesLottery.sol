pragma solidity ^0.8.11;

contract SoliditySnakesLottery{
    address public owner;
    address payable[] public players;



    constructor(){
        owner = msg.sender; //My deployment address set to Owner
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

    function enter() public payable{
        //cost to enter lottery
        require(msg.value == 0.1 ether, "You need to send 0.1 Ether");
        players.push(payable(msg.sender)); //Get address of user who join lottery to payable array
    }

    function RandomNumber() public view returns (uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp))); //psuedo randomaness by concatinating 2 variables
    }

    function pickWinner() public {
        require(msg.sender == owner);
        uint index = RandomNumber() % players.length; 
        players[index].transfer(address(this).balance); //Send Ether to the winner

        //Reset for the next round 
        players = new address payable[](0);
    }
    }
