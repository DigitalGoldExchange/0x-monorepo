pragma solidity ^0.4.21;
pragma experimental ABIEncoderV2;

import "../protocol/Exchange/Exchange.sol";
import "../utils/SafeMath/SafeMath.sol";

contract AbiTest is SafeMath
{
    Exchange exchange;
    function Forwarder(Exchange _exchange)
       public
    {
        exchange = _exchange;
    }

    function fillOrders(Exchange.Order[] orders, uint256 makerTokenFillAmount, bytes[] signatures)
        payable
        public
        returns (Exchange.FillResults memory totalFillResult)
    {
        Exchange.FillResults memory fillTokensFillResult = exchange.marketSellOrders(
            orders,
            makerTokenFillAmount,
            signatures);
        addFillResults(totalFillResult, fillTokensFillResult);
        return totalFillResult;
    }

    function addFillResults(Exchange.FillResults memory totalFillResults, Exchange.FillResults memory singleFillResults)
        internal
        pure
    {
        totalFillResults.makerTokenFilledAmount = safeAdd(totalFillResults.makerTokenFilledAmount, singleFillResults.makerTokenFilledAmount);
        totalFillResults.takerTokenFilledAmount = safeAdd(totalFillResults.takerTokenFilledAmount, singleFillResults.takerTokenFilledAmount);
        totalFillResults.makerFeePaid = safeAdd(totalFillResults.makerFeePaid, singleFillResults.makerFeePaid);
        totalFillResults.takerFeePaid = safeAdd(totalFillResults.takerFeePaid, singleFillResults.takerFeePaid);
    }
}