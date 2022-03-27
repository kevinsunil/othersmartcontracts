//SPDX-License-Identifier:MIT
pragma solidity >=0.6.0 <0.9.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
contract FundMe {
    using SafeMathChainlink for uint256;
    mapping(address => uint256) public addressToAmountFunded;
    function fund() public payable{
        addressToAmountFunded[msg.sender] += msg.value;
    }
    function getVersion() public view returns (uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        return pricefeed.version();
    }
    function getPrice() public view returns (uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
         (,int price,,,) = pricefeed.latestRoundData();
        return uint256(price * 10000000000);
    }
    function getConversion(uint256 ethAmount) public  view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethConvert = (ethPrice * ethAmount)/10000000000;
        return ethConvert;
    }
}
