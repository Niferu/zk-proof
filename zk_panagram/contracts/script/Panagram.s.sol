// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {Panagram} from "../src/Panagram.sol";

contract PanagramScript is Script {
    Panagram public panagram;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        panagram = new Panagram();

        vm.stopBroadcast();
    }
}
