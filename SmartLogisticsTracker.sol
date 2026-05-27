// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartLogisticsTracker {

    struct LogisticsData {
        string shipmentId;
        string vehicleId;
        string route;
        string dataTimestamp;

        string gpsLatitude;
        string gpsLongitude;
        string vehicleSpeedKmh;

        string rfidTagId;
        string rfidScanStatus;
        string packageStatus;

        string temperatureC;
        string alertStatus;
    }

    address public owner;
    uint256 public constant MAX_ENTRIES = 200;

    LogisticsData[] private logisticsRecords;

    event LogisticsDataStored(
        string shipmentId,
        string vehicleId,
        string rfidTagId,
        string alertStatus
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can store data");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeLogisticsData(
        string memory _shipmentId,
        string memory _vehicleId,
        string memory _route,
        string memory _dataTimestamp,
        string memory _gpsLatitude,
        string memory _gpsLongitude,
        string memory _vehicleSpeedKmh,
        string memory _rfidTagId,
        string memory _rfidScanStatus,
        string memory _packageStatus,
        string memory _temperatureC,
        string memory _alertStatus
    ) public onlyOwner {
        require(logisticsRecords.length < MAX_ENTRIES, "Maximum records reached");

        logisticsRecords.push(
            LogisticsData(
                _shipmentId,
                _vehicleId,
                _route,
                _dataTimestamp,
                _gpsLatitude,
                _gpsLongitude,
                _vehicleSpeedKmh,
                _rfidTagId,
                _rfidScanStatus,
                _packageStatus,
                _temperatureC,
                _alertStatus
            )
        );

        emit LogisticsDataStored(
            _shipmentId,
            _vehicleId,
            _rfidTagId,
            _alertStatus
        );
    }

    function getTotalRecords() public view returns (uint256) {
        return logisticsRecords.length;
    }

    function getRecord(uint256 index)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        require(index < logisticsRecords.length, "Record does not exist");

        LogisticsData memory record = logisticsRecords[index];

        return (
            record.shipmentId,
            record.vehicleId,
            record.route,
            record.dataTimestamp,
            record.gpsLatitude,
            record.gpsLongitude,
            record.vehicleSpeedKmh,
            record.rfidTagId,
            record.rfidScanStatus,
            record.packageStatus,
            record.temperatureC,
            record.alertStatus
        );
    }
}