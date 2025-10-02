// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {Panagram} from "../src/Panagram.sol";
import {HonkVerifier} from "../src/Verifier.sol";

contract PanagramTest is Test {
    Panagram public panagram;
    HonkVerifier public verifier;

    function setUp() public {
        verifier = new HonkVerifier();
        panagram = new Panagram(verifier);
    }
}
