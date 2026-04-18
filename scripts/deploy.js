const hre = require("hardhat");

async function main() {
  const Rep = await hre.ethers.getContractFactory("ReputationEngine");
  const rep = await Rep.deploy();
  await rep.waitForDeployment();

  const Quest = await hre.ethers.getContractFactory("FarcasterQuestEngine");
  const quest = await Quest.deploy(await rep.getAddress());
  await quest.waitForDeployment();

  console.log("REP:", await rep.getAddress());
  console.log("QUEST:", await quest.getAddress());
}

main();
