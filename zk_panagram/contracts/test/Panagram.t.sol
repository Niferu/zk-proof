// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {Panagram} from "../src/Panagram.sol";

contract PanagramTest is Test {
    Panagram public panagram;

    function setUp() public {
        panagram = new Panagram();
        panagram.setNumber(0);
    }

    function test_Increment() public {
        panagram.increment();
        assertEq(panagram.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        panagram.setNumber(x);
        assertEq(panagram.number(), x);
    }
}
