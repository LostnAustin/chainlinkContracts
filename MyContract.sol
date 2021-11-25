pragma solidity 0.5.1;

contract MyContract {
    Person[] public people;
    
    uint256 public peopleCount;
    mapping(uint => Person) public people;
    // mapping method to add person function
    
    uint256 openingTime = 1544669573;
    // start epoch time for uint256. This is how to set basic timer for contract function execution.
        modifier onlyWhileOpen() {
            require(block.timestamp >= openingTime);
        _;
        }
        
        address owner;
        
        modifier onlyOwner() {
            require(msg.sender == owner)
            _;
            // throws error
            
        }
        
        struct Person {
            uint _id;
            string _firstName;
            string _lastName;
        }
        
        // constructor to link message and owner
        constructor() public {
            owner = msg.sender;
        }
        
        
        function addPerson(
            string memory _firstName, string memory _lastName
            ) 
            public onlyOwner
            {
            // people.push(Person(_firstName, _lastName));
            peopleCount +=1;
            people[peopleCount] = Person(peopleCount, _firstName, _lastName);
            }
        
        // function incrementCount() internal {
        //     peopleCount += 1;
        //     // internal contract function not accessible outside
        // }
}



// contract MyContract {
//     // see current state of contract
//     enum State { Waiting, Ready, Active }
//     State public state;
    
//     constructor() public {
//         state = State.Waiting;
//     }
    
//     function activate() public {
//         state = State.Active;
//     }
    
//     function isActive() public view returns(bool) {
//         return state == State.Active;
//     }
    // string public constant value = "myValue of Link Data";
    // bool public myBool = true;
    // int public myBool = true;
    // int public myInt = -1;
    // uint public myUnit = 1;
    // uint8 public myUint8 = 8;
    // }
    // string public value = "myValue";
    
    // constructor() public {
        
    // }
    
    // function set(string memory _value) public {
    //     value = _value;
    // }
