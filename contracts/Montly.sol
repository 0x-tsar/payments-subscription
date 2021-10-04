// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Montly {
    mapping(address => uint256) public lastPayment;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function makePayment() external payable {
        require(
            block.timestamp >= lastPayment[msg.sender] + 20 seconds,
            "Already paid"
        );
        require(msg.value >= 0.1 ether, "Value must be 0.1 or higher");
        lastPayment[msg.sender] = block.timestamp;
    }

    function retrievePayment() external {
        require(
            admin == msg.sender,
            "you must be admin to retrieve all the payments from this contract"
        );

        payable(msg.sender).transfer(address(this).balance);
    }
}
