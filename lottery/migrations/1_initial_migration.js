var Migrations = artifacts.require("./lotterycontract.sol");

module.exports = function(deployer) {
  deployer.deploy(lotterycontract);
};
