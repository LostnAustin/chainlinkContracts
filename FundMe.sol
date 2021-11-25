// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 < 0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

//for solidity prior to 0.8, use SafeMath for math functions
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint256;
    
    mapping(address =>uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function fund() public payable {
        //$50 in gwei. 50 x (10^18)
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more Eth!");
        addressToAmountFunded[msg.sender] += msg.value;
        //determine currency conversion. eg) eth > usd
        funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface();
        return priceFeed.version();
    }
    
    function getPrice() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface();
        // use type casting uint > int256
        // use commas to acknowledge but negate revieving the value calldata
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer); 
    }
    
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 100000000000000000;
        return ethAmountInUsd;
    }
    
    // the rest of the contract is run after the "_"
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    //use the contract to send the fund money to an address
    //only want contract admin/owner
    // require msg.sender = owner
    function withdraw() payable onlyOwner public {
        //replaced require with modifier from above
        // require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
        
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex ++) {
            address funder = funders[funderIndex];
            //reset funder amount to zero after withdraw
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
