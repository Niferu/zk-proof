// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Script} from "forge-std/Script.sol";
import {Panagram} from "../src/Panagram.sol";
import {HonkVerifier} from "../src/Verifier.sol";

contract PanagramScript is Script {
    Panagram public panagram;
    HonkVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        verifier = new HonkVerifier();
        panagram = new Panagram(verifier);

        vm.stopBroadcast();
    }
}
