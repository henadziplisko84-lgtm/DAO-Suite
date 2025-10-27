// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorTimelockControl.sol";


contract GovernorContract is Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes, GovernorTimelockControl {
constructor(IVotes _token, TimelockController _timelock)
Governor("GameGovernor")
GovernorSettings(1 /* voting delay */ , 45818 /* voting period (~1 week on ETH ~13s) adjust for Base */, 0)
GovernorVotes(_token)
GovernorTimelockControl(_timelock)
{}


// The following functions are overrides required by Solidity.
function votingDelay() public view override(Governor, GovernorSettings) returns (uint256) {
return super.votingDelay();
}


function votingPeriod() public view override(Governor, GovernorSettings) returns (uint256) {
return super.votingPeriod();
}


function quorum(uint256 blockNumber) public pure override returns (uint256) {
// simple fixed quorum (for demo). Consider dynamic quorum or percent of total supply
return 1000 * 10 ** 18; // 1000 tokens
}


// The functions below are required overrides by Solidity.
function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description)
public
override(Governor)
returns (uint256)
{
return super.propose(targets, values, calldatas, description);
}


function _execute(uint256 proposalId, address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
internal
override(Governor, GovernorTimelockControl)
{
super._execute(proposalId, targets, values, calldatas, descriptionHash);
}


function _cancel(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
internal
override(Governor, GovernorTimelockControl)
returns (uint256)
{
return super._cancel(targets, values, calldatas, descriptionHash);
}


function _executor() internal view override(Governor, GovernorTimelockControl) returns (address) {
return super._executor();
}


function supportsInterface(bytes4 interfaceId)
public
view
override(Governor, GovernorTimelockControl)
returns (bool)
{
return super.supportsInterface(interfaceId);
}
}
