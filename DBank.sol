// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DecentralizedBank {
    address public owner;
    uint public totalFunds;
    uint public oneMinuteRate = 1;
    uint public oneMonthRate = 3;
    uint public sixMonthsRate = 9;
    uint public oneYearRate = 18;

    struct Investment {
        uint amount;
        uint timestamp;
        uint duration; // Duration in seconds
        bool withdrawn;
    }

    mapping(address => Investment[]) public investments;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier validDuration(uint _duration) {
        require(
            _duration == 1 minutes || _duration == 30 days || _duration == 180 days || _duration == 360 days,
            "Invalid investment duration"
        );
        _;
    }

    event Invest(address indexed investor, uint amount, uint duration);
    event Withdraw(address indexed investor, uint amount);

    constructor() payable {
        require(msg.value == 10 ether, "Initial funds must be 10 ETH");
        owner = msg.sender;
        totalFunds = msg.value;
    }

    function invest(uint _duration) external payable validDuration(_duration) {
        require(msg.value > 0, "Investment amount must be greater than zero");

        investments[msg.sender].push(
            Investment({
                amount: msg.value,
                timestamp: block.timestamp,
                duration: _duration, // Duration in seconds
                withdrawn: false
            })
        );

        totalFunds += msg.value;

        emit Invest(msg.sender, msg.value, _duration);
    }

    function withdraw(uint _index) external {
        Investment storage investment = investments[msg.sender][_index];
        require(!investment.withdrawn, "Investment already withdrawn");
        require(block.timestamp >= investment.timestamp + investment.duration, "Investment period not yet ended");

        uint rate;
        if (investment.duration == 1 minutes) { // 1 minute
            rate = oneMinuteRate;
        } else if (investment.duration == 30 days) { // 1 month
            rate = oneMonthRate;
        } else if (investment.duration == 180 days) { // 6 months
            rate = sixMonthsRate;
        } else if (investment.duration == 360 days) { // 12 months
            rate = oneYearRate;
        }

        uint interest = (investment.amount * rate) / 100;
        uint payout = investment.amount + interest;

        require(totalFunds >= payout, "Not enough funds in the bank");

        investment.withdrawn = true;
        totalFunds -= payout;
        payable(msg.sender).transfer(payout);

        emit Withdraw(msg.sender, payout);
    }

    function addFunds() external payable onlyOwner {
        require(msg.value > 0, "Amount must be greater than zero");
        totalFunds += msg.value;
    }
}