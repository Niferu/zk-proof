# ZK Panagram

- Each 'answer' is a 'round'
- The owner is the only person that can start a new round
- The round needs to have a minimum duration
- There needs to be a 'winner' to start the next round
- The winner is first person that submits correct answer
- The contract needs to be an NFT contract
  - ERC-1155 (token id 0 for winners, token id 1 for runners up)
  - Mint id 0 for first winner
  - Mint id 1 if user submitted correct answer but was not first
- To check if the user guess was correct, we will call the Verifier smart contract
