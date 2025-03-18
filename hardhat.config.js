require("@nomicfoundation/hardhat-verify");
require("hardhat-deploy");
require("dotenv").config();
require("@solarity/hardhat-gobind");

const { PRIVATE_KEY, PUPPY_RPC_URL, ETHERSCAN_API_KEY } =
  process.env;

console.log("Loaded Private Key:", PRIVATE_KEY);

module.exports = {
  solidity: {
    version: "0.8.25",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
      1: 0,
    },
  },
  networks: {
    puppy: {
      url: PUPPY_RPC_URL,
      chainId: 157,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    }
  },
  etherscan: {
    apiKey: {
      puppy: ETHERSCAN_API_KEY || "empty",
    },
    customChains: [
      {
        network: "puppy",
        chainId: 157,
        urls: {
          apiURL: "https://puppyscan.shib.io/api",
          browserURL: "https://puppyscan.shib.io",
        },
      }
    ],
  },
};
