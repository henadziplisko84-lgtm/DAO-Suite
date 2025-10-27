// ... существующий код


async function main() {
const [deployer] = await hre.ethers.getSigners();
console.log("Deploying with:", deployer.address);


// Deploy Governance Token
const GovernanceToken = await hre.ethers.getContractFactory("GovernanceToken");
const gtoken = await GovernanceToken.deploy();
await gtoken.deployed();
console.log('GovernanceToken:', gtoken.address);


// Timelock
const minDelay = 2 * 60; // 2 minutes for demo; on mainnet use >= 2 days
const proposers = [];
const executors = [];


const Timelock = await hre.ethers.getContractFactory("@openzeppelin/contracts/governance/TimelockController.sol:TimelockController");
const timelock = await Timelock.deploy(minDelay, proposers, executors);
await timelock.deployed();
console.log('Timelock:', timelock.address);


// Governor
const Governor = await hre.ethers.getContractFactory("GovernorContract");
const governor = await Governor.deploy(gtoken.address, timelock.address);
await governor.deployed();
con
