// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ISubscriptionToken {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract Subscription {
    ISubscriptionToken public immutable token;
    address public immutable subscriptionOrganization;
    uint256 public immutable price;
    uint256 public constant MONTH_LENGTH = 30 days;

    mapping(address => uint256) public dueDate;

    event SubscriptionPaid(address indexed subscriber, uint256 amount, uint256 paidUntilTime);

    constructor(address tokenAddress, address organizationAddress, uint256 subscriptionPrice) {
        require(tokenAddress != address(0), "Token address is zero");
        require(organizationAddress != address(0), "Organization address is zero");
        require(subscriptionPrice > 0, "Price must be greater than 0");

        token = ISubscriptionToken(tokenAddress);
        subscriptionOrganization = organizationAddress;
        price = subscriptionPrice;
    }

    function paySubscription() external {
        bool success = token.transferFrom(msg.sender, subscriptionOrganization, price);
        require(success, "Payment failed");

        uint256 baseTime = dueDate[msg.sender] > block.timestamp
            ? dueDate[msg.sender]
            : block.timestamp;

        uint256 newDueDate = baseTime + MONTH_LENGTH;
        dueDate[msg.sender] = newDueDate;

        emit SubscriptionPaid(msg.sender, price, newDueDate);
    }

    function hasActiveSubscription(address user) external view returns (bool) {
        return dueDate[user] > block.timestamp;
    }

    function getDueDate(address user) external view returns (uint256) {
        return dueDate[user];
    }
}
