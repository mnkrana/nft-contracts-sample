const { network } = require("hardhat");
const { verify } = require("../utils/verify");
require("dotenv").config();
require("hardhat-deploy");

async function deployRana({ getNamedAccounts, deployments }) {
  console.log("Deploying rana contract...");

  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const initialUri =
    "ipfs://QmXdHFZYPMf6AizqVmJrXPgNfyfYtr2oErpDy9JKywX21E";

  log("----------------------------------------------------");
  log(network.config.chainId);
  log("Deploying, waiting for confirmations...");
  const args = [deployer, initialUri];
  const rana = await deploy("Rana", {
    from: deployer,
    args: args,
    log: true,
    waitConfirmations: 6,
  });
  log(`Rana deployed at ${rana.address}`);
  await verify(rana.address, args);
}

module.exports.default = deployRana;
module.exports.tags = ["all", "rana"];
