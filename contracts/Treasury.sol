// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/access/Ownable.sol";


/// @title Treasury - хранит средства DAO. Выполнение транзакций может делать Timelock (через Governor).
contract Treasury is Ownable {
event Executed(address indexed target, uint256 value, bytes data);


receive() external payable {}


function execute(address target, uint256 value, bytes calldata data) external onlyOwner returns (bytes memory) {
(bool success, bytes memory result) = target.call{value: value}(data);
require(success, "execution failed");
emit Executed(target, value, data);
return result;
}
}
