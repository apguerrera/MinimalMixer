pragma solidity ^0.5.4;

import "../Shared/Owned.sol";
// import "../Dependencies/verifier.sol";

contract MiMC{
    function MiMCpe7(uint256,uint256,uint256,uint256) public pure returns (uint256) {}
}
contract Verifier {
    function verifyProof(
          uint[2] memory a,
          uint[2][2] memory b,
          uint[2] memory c,
          uint[1] memory input
    ) view public returns (bool) {}
}

contract MinimalMixer is Owned {

    MiMC public mimc;
    Verifier public verifier;
    event Deposited(uint256 amount);

    constructor () public {
      initOwned(msg.sender);
    }

    function setMiMC(address _mimc) public onlyOwner {
      mimc = MiMC(_mimc);
    }
    function setVerifier(address _verifier) public onlyOwner {
      verifier = Verifier(_verifier);
    }

    function deposit(bytes32 commitment) public payable {
      emit Deposited(msg.value);
    }

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
