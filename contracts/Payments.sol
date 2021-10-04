// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Payments is ERC20 {
    address public admin;
    mapping(address => uint256) public personSalary;
    mapping(address => uint256) public dateBegin;

    constructor() ERC20("Company Token", "COTO") {
        admin = msg.sender;
    }

    function createPerson(address _address) external {
        personSalary[_address] = 100_000 ether;
        dateBegin[_address] = block.timestamp;
    }

    function retrieveSalary() external {
        uint256 salary = personSalary[msg.sender];
        uint256 hourly = calculateHourRate(5, 5);
        _mint(msg.sender, salary);
    }

    // hours of work * hours per week * numbers of weeks
    // in a year, then divide for the anual salary
    // (8*7*52) / 100_000

    function calculateHourRate(uint256 hourPerDay, uint256 daysOfWorkPerWeek)
        public
        view
        returns (uint256)
    {
        uint256 SALARY_ANUAL = personSalary[msg.sender];
        return SALARY_ANUAL / (hourPerDay * daysOfWorkPerWeek * 52);
    }

    //185 basis points = 1.85 pct
    function calculateFee(uint256 amount) external pure returns (uint256) {
        require((amount / 10000) * 10000 == amount, "too small");

        return (amount * 185) / 10000;
    }
}

// First, determine the total number of hours worked by multiplying the hours per week by the number of weeks in a year (52). Next, divide this number from the annual salary. For example, if an employee has a salary of $50,000 and works 40 hours per week, the hourly rate is $50,000/2,080 (40 x 52) = $24.04.
// function calculateHourRate(uint256 hourPerDay, uint256 daysOfWorkPerWeek)
//     external
//     pure
//     returns (uint256)
// {
//     uint256 SALARY_ANUAL = 100_000;
//     return SALARY_ANUAL / (hourPerDay * daysOfWorkPerWeek * 52);
// }
