// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@thirdweb-dev/contracts/prebuilts/account/non-upgradeable/Account.sol";
import "./CustomAccountFactory.sol";

contract CustomAccount is Account {
    constructor(
        IEntryPoint _entrypoint,
        address _factory
    ) Account(_entrypoint, _factory) {
        _disableInitializers();
    }
    function register(
        string calldata username,
        string calldata metadataUri
        ) external {
        require(msg.sender == address(this), "Only account can register");
        CustomAccountFactory(factory).onRegistered(username);
        _setupContractURI(metadataUri);
    }
}