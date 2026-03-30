const StudentToken = artifacts.require("StudentToken");
const Subscription = artifacts.require("Subscription");

module.exports = async function (deployer, network, accounts) {
  const initialSupply = web3.utils.toWei("1000000", "ether");
  const subscriptionPrice = web3.utils.toWei("10", "ether");
  const userStartBalance = web3.utils.toWei("50", "ether");

  await deployer.deploy(StudentToken, "Student Token", "STUD", initialSupply);
  const token = await StudentToken.deployed();

  await deployer.deploy(Subscription, token.address, accounts[0], subscriptionPrice);
  const sub = await Subscription.deployed();

  await token.transfer(accounts[1], userStartBalance, { from: accounts[0] });
};
