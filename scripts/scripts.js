const Payments = artifacts.require("Payments");

module.exports = async () => {
  const payments = await Payments.deployed();
  // console.log(payments.methods);
  const hr = await payments.calculateHourRate(24, 5);
  console.log(parseFloat(hr));
  // > 50_000 / (5*5*52)
  // > 100_000 / (5*5*52)
  // 76.92307692307692
};
