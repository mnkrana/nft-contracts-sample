const { ethers } = require("ethers"); 
const { network} = require("hardhat");
const { verify } = require("../utils/verify");
require("dotenv").config();
require("hardhat-deploy");

async function deployRanaMarket({ getNamedAccounts, deployments }) {
  console.log("Deploying rana market contract...");

  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const nftPrice = ethers.utils.parseEther("0.01");
  
  log("----------------------------------------------------");
  log(network.config.chainId);
  log("Deploying, waiting for confirmations...");
  const args = [nftPrice];
  const ranaMarket = await deploy("RanaMarket", {
    from: deployer,
    args: args,
    log: true,
    waitConfirmations: 6,
  });
  log(`Rana deployed at ${ranaMarket.address}`);
  await verify(ranaMarket.address, args);
}

module.exports.default = deployRanaMarket;
module.exports.tags = ["ranaMarket"];
