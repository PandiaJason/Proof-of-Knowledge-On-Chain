// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "remix_accounts.sol";
import "../contracts/nttSetup.sol";

contract NTTtest{

    NTT nntToTest;
    address acc0;
    address acc1;

    function beforeEach() public {
        acc0 = TestsAccounts.getAccount(0); 
        acc1 = TestsAccounts.getAccount(1);
        nntToTest = new NTT(acc1);

    }

    function checkInitialize() public{
        // Here checks the nntHolder
        Assert.equal(msg.sender,acc0,"valid");
        Assert.equal(acc1,TestsAccounts.getAccount(1),"valid");
        Assert.notEqual(acc1,TestsAccounts.getAccount(2),"valid");
    }

    function checkHolder() public {
        Assert.equal(nntToTest.nttHolder(), acc1, "equal");
        // Assert.equal(nntToTest.name(),"Non-Transferable-Token", "equal");


    }

    function checkBalanceBefore() public{
        nntToTest.balanceOf(acc1);
        Assert.equal( nntToTest.balanceOf(acc1), 0, "equal");

    }

    function checkNttIsMinted() public {
        Assert.equal(nntToTest._tokenIds(), 0, "equal");
        nntToTest.addNtt("Jason");
        Assert.equal(nntToTest._tokenIds(), 1, "equal");
        Assert.notEqual(nntToTest._tokenIds(), 0, "equal");

    }

    function checkBalanceAfter() public{
        nntToTest.addNtt("Jason");
        nntToTest.balanceOf(acc1);
        Assert.equal( nntToTest.balanceOf(acc1), 1, "equal");

    }


}
