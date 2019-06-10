pragma solidity ^0.5.4;

import "../Shared/Owned.sol";

contract MiMC{
    function MiMCpe7(uint256,uint256,uint256,uint256) public pure returns (uint256) {}
}


contract MinimalMixer is Owned {

    MiMC mimc;

    constructor () public {
      initOwned(msg.sender);
    }

    function init(address _mimc) public onlyOwner {
      mimc = MiMC(_mimc);
    }

    function deposit(bytes32 commitment) public payable {}
    function withdraw(address destination, bytes memory proof) public view {
      uint fee = calculateFee();
    }

    function hashCommitment() public view returns (uint256) {

    }
    function calculateFee() public view returns (uint256) {
      // return (1.0722 ** (block.number % 100) % 10);
      return (1 ** (block.number % 100) % 10);
    }

}
