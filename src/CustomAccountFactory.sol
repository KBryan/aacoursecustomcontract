// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@thirdweb-dev/contracts/prebuilts/account/utils/BaseAccountFactory.sol";
import "./CustomAccount.sol";

contract CustomAccountFactory is BaseAccountFactory {
    event Registered(string username, address account);
    mapping(string => address) public accountOfUsername;

    constructor(
        IEntryPoint _entrypoint
    )
    BaseAccountFactory(
    address (new CustomAccount(_entrypoint,address(this))),
    address(_entrypoint)
    )
    {}

    function _initializeAccount(
        address _account,
        address _admin,
        bytes calldata
    ) internal override {
        CustomAccount(payable(_account)).initialize(_admin, "");
    }

    function onRegistered(string calldata username  ) external {
        address account = msg.sender;
        require(this.isRegistered(account),"Not an account");
        require(accountOfUsername[username] == address (0), "Username taken...");
        accountOfUsername[username] = account;
        emit Registered(username,account);
    }
}
