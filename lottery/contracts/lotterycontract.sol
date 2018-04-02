pragma solidity ^0.4.19;

contract Lottery {

   uint flag = 0;
   address private manager;
   mapping(address => player) players;
   address[] public playerAccounts;
   bytes32[] public GuessMade;
   uint[] public CoinUsed;
   bytes32 private number;
   address winner;


// constructor, the lottery number is generated from contract creators transaction value

   function Lottery() public payable {
       require(msg.value >= 1 wei && msg.value <= 1000000 wei);
       manager = msg.sender;
       number = keccak256(msg.value);
}
   struct player {
       bytes32 guess;
       uint coin;
}

   // entering the lottery requires value grater than 1 ether

     function enter() public payable {
        if (flag == 0) {
           require(msg.value >= 1 ether);
          var tokenHolder = players[msg.sender];
          tokenHolder.coin = (uint(msg.value/1 ether));
          CoinUsed.push(uint(msg.value/1 ether));
}
       else {
           msg.sender.transfer(msg.value);
      }
}

// making guess in lottery, require address and guess number

   function makeGuess (address _address, uint _guess ) public {
       if (flag == 0) {
       var entrant = players[_address];
       if (entrant.coin > 0) {
       entrant.guess = keccak256(_guess);
       playerAccounts.push(_address);
       GuessMade.push(keccak256(_guess));
       entrant.coin -= 1;
       CoinUsed.push(entrant.coin);
   }
   else {
       revert();
   }
   }
     else {
         revert();
     }
   }

   // winner address, associated with the matching guess number


      function winneraddress () public returns(address) {
          if (msg.sender == manager) {
              for (uint i = 0; i <= GuessMade.length; i++) {
                  if (GuessMade[i] == number){
                      return winner = playerAccounts[i];
                      }
                  else {
                      revert();
                  }
              }
          }
          else {
              revert();
          }
        }
  // closegame called by manager

       function closeGame ()  public payable {
         require(msg.value == 1 wei);
          if (msg.sender == manager) {
           flag += 1;
           }
       }
// winner getting half of the fund in the contract

    function  getPrice () public payable {
        require(msg.value == 1 wei);
        require(msg.sender == winner);
        msg.sender.transfer((this.balance)/2);
        manager.transfer(this.balance);
       }
}
