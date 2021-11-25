
pragma solidity ^0.6.0;

contract SimpleStorage {
    //initialized as 0 value if not set
    uint256 public favoriteNumber;
    bool favoriteBool;
    
    // function types: external, public, internal and private
    
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    // view function (below) and pure functions (mathematical function) eg) add favoriteNumber + favoriteNumber below
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    
    // define new types in solidity
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;
    // People public person = People ({favoriteNumber: 2, name: "Chad"});
    
    // string persists the variable. memory means just use variable once
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
         nameToFavoriteNumber[_name] = _favoriteNumber;
    //could also just use _favoriteNumber, _name
    //map name to favorite number
   
    }
}
