// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DriverRegistry {
    struct Driver {
        uint256 driverId;
        string name;
        string licenseNumber;
        string fastTagId;
        string walletLinkingId;
        uint256 accountBalance; // in wei (1 ether = 10^18 wei)
    }

    uint256 public driverCount;
    mapping(uint256 => Driver) public drivers;

    event DriverRegistered(uint256 driverId, string name);
    event AccountBalanceUpdated(uint256 driverId, uint256 newBalance);

    function registerDriver(
        string memory _name,
        string memory _licenseNumber,
        string memory _fastTagId,
        string memory _walletLinkingId
    ) public {
        driverCount++;
        drivers[driverCount] = Driver(
            driverCount,
            _name,
            _licenseNumber,
            _fastTagId,
            _walletLinkingId,
            0
        );
        emit DriverRegistered(driverCount, _name);
    }

    function getDriverInfo(uint256 _driverId)
        public
        view
        returns (
            string memory name,
            string memory licenseNumber,
            string memory fastTagId,
            string memory walletLinkingId,
            uint256 accountBalance
        )
    {
        require(_driverId <= driverCount && _driverId > 0, "Invalid driver ID");
        Driver storage driver = drivers[_driverId];
        return (
            driver.name,
            driver.licenseNumber,
            driver.fastTagId,
            driver.walletLinkingId,
            driver.accountBalance
        );
    }

    function getAccountBalance(uint256 _driverId) public view returns (uint256) {
        require(_driverId <= driverCount && _driverId > 0, "Invalid driver ID");
        return drivers[_driverId].accountBalance;
    }

    function updateAccountBalance(uint256 _driverId, uint256 _newBalance) public {
        require(_driverId <= driverCount && _driverId > 0, "Invalid driver ID");
        drivers[_driverId].accountBalance = _newBalance;
        emit AccountBalanceUpdated(_driverId, _newBalance);
    }
}
