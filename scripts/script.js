const Montly = artifacts.require("Montly");

module.exports = async () => {
  const montly = await Montly.deployed();
  const [account1, _] = await web3.eth.getAccounts();

  let COUNTER = 0;

  console.log("Starting node...");
  // const retrievingFunds = await montly.retrievePayment();

  setInterval(async () => {
    try {
      console.log("calling..");

      let tx = await montly.makePayment({
        from: account1,
        value: web3.utils.toWei("0.1"),
      });

      console.log(tx);
      COUNTER += 1;
      console.log(`payments made: ${COUNTER}`);
    } catch (error) {
      console.log(error);
    }
  }, 1000 * 20);
};
