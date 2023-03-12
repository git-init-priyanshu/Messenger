const messenger = artifacts.require("Messenger");

module.exports = function (deployer) {
  deployer.deploy(messenger);
};
