pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract Bond {
    // Public variables of the token
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    string bondperiod
    // 18 decimals is the strongly suggested default, avoid changing it
    uint256 public totalSupply;

    // This creates an array with all balances
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Transfer(address ind0-exed from, address indexed to, uint256 value);

    

    /**
     * Constructor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    function TokenERC20(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
        uint16 timestamp
        uint16 maturitydate
        uint16 bonddate 
        
    ) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);  // Update total supply with the decimal amount
        balanceOf[msg.sender] = totalSupply;                // Give the creator all initial tokens
        name = tokenName;                                   // Set the name for display purposes
        symbol = tokenSymbol;  
        timestamp = getDay(uint timestamp)// Get the current day
        maturitydate = 184046599    // setting maturity time as 04/27/2018 approx ten years into the future
        bonddate = 1524847302
        parvalue = 1000
        annualrate = 0.07  //assuming the annual rates and coupon rate
        couponrate = 0.009  
    }
    
    
    /**
     * Internal transfer, only can be called by this contract
     */
    function _transferbond(address _from, address _to, bondvalue) internal {
        if(timestamp> maturity) //check the maturity date of the bond...if current date exceeds, exit
        {
            exit()
        }
        else 
        {   uint256 date = new Date;
            uint16 year = date.getYear(); // get current year to find the bond value
            uint16 bondyear = bonddate.getYear(); // get beginning of bond year
            uint16 i = 0;
            yearsremaining = year - bondyear
            couponpaidperyear = bondprincipal * couponrate
            coupondiscounted = 0
            for(i=0; i<yearsremaining; i++) 
            {
                coupondiscounted + = couponpaidperyear/((1+annualrate)**i)
                
            }
            MaturityDiscounted = parvalue/((1+annualrate)**yearsremaining)
            bondvalue = coupondiscounted + MaturityDiscounted
            _value = 0.0015459534668006492 * bondvalue
            
            
            require(_to != 0x0);
            
            require(balanceOf[_frovm] >= _value); //check if sender has enough balance
            require(balanceOf[_to] + _value >= balanceOf[_to]); //check for overflow of balance
            // Save this for an assertion in the future
            uint previousBalances = balanceOf[_from] + balanceOf[_to];
            // Subtract from the sender
            balanceOf[_from] -= _value;
            // Add the same to the recipient
            balanceOf[_to] += _value;
            emit Transfer(_from, _to, _value);
             // Asserts are used to use static analysis to find bugs in your code. They should never fail
             assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
        }
    }

    //Send _value tokens from senders account
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    /**
     * Transfer tokens from other address
     *
     * Send `_value` tokens to `_to` on behalf of `_from`
     *
     * @param _from The address of the sender
     * @param _to The address of the recipient
     * @param _value the amount to send
     */
     //transfer from one address to another
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    //checks the fund balance to approve the transaction
    function approve(address _spender, uint256 _value) public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    // check to see if spender cannot spend more than value
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        public
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    // Remove `_value` tokens from the system irreversibly
     
    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }

    //Remove `_value` tokens from the system irreversibly on behalf of `_from`.

    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value);                // Check if the targeted balance is enough
        require(_value <= allowance[_from][msg.sender]);    // Check allowance
        balanceOf[_from] -= _value;                         // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
        totalSupply -= _value;                              // Update totalSupply
        emit Burn(_from, _value);
        return true;
    }
}
