// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract RentingHouseContract {
    address public landlord;
    
    struct Tenant {
        string name;
        string _address;
    }
    
    struct Property {
        string _address;
        uint256 leaseStart;
        uint256 leaseEnd;
        string tenantReviews;
    }
    
    mapping(address => Tenant) public tenants; //call tenants
    mapping(address => Property) public rentedProperties; //call property

    event RentedProperty(address indexed tenantAddress, string propertyAddress); //rent event and parameters
    event LeaseTerminated(address indexed tenantAddress, string propertyAddress); //leasing rent and parameters
    
    constructor() {
        landlord = msg.sender; //constructor wallet address for one time
    }
    
    //check landlord address
    modifier checkLandlord() {
        require(msg.sender == landlord, "Only the landlord can perform this operation.");
        _;
    }
    
    //renting function
    function rentProperty(string memory tenantName, string memory tenantAddress, string memory propertyAddress, uint256 leaseStart, uint256 leaseEnd, string memory tenantReviews) external {
        require(bytes(tenantName).length > 0, "Tenant name cannot be empty");
        require(bytes(tenantAddress).length > 0, "Tenant address cannot be empty");
        require(bytes(propertyAddress).length > 0, "Property address cannot be empty");
        require(leaseStart < leaseEnd, "Lease start date must be before lease end date");
        
        Tenant storage tenant = tenants[msg.sender];
        tenant.name = tenantName;
        tenant._address = tenantAddress;
        
        Property storage property = rentedProperties[msg.sender];
        property._address = propertyAddress;
        property.leaseStart = leaseStart;
        property.leaseEnd = leaseEnd;
        property.tenantReviews = tenantReviews;
        
        emit RentedProperty(msg.sender, propertyAddress);
    }
    
    //lease terminate function
    function terminateLease(string memory propertyAddress) external checkLandlord {
        delete tenants[msg.sender];
        delete rentedProperties[msg.sender];
        
        emit LeaseTerminated(msg.sender, propertyAddress);
    }
}
