// const Payments = artifacts.require("Payments");
const Montly = artifacts.require("Montly");

module.exports = function (deployer) {
  deployer.deploy(Montly);
};
