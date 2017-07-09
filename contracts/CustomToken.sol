/*
Custom Token Contract implementing ERC20 Standard.
Sends all initial tokens to the creator of the contract.
Owner can change name and symbol and description of token.
Owner can create additional tokens
Anyone can donate to owner
*/

import "./ERC20Token/StandardToken.sol";

pragma solidity ^0.4.8;

contract CustomToken is StandardToken {
      
    function () {
        throw;
    }
    modifier restricted() {
        if (msg.sender == owner) _;
    }

    address public owner;
    string public version = '0.1';
    string public name;              
    string public symbol;            
    string public description;           

    function CustomToken(
        uint256 _initialAmount,
        string _tokenName
        ) {
        owner = msg.sender;
        balances[msg.sender] = _initialAmount;               
        totalSupply = _initialAmount;                        
        name = _tokenName;                            
    }

    function UpdateSettings(string _tokenName, string _tokenSymbol, string _description) restricted {
        if(sha3(name) != sha3(""))                
            name = _tokenName;  
        if(sha3(_tokenSymbol) != sha3("")) 
            symbol = _tokenSymbol;
        if(sha3(_description) != sha3("")) 
            description = _description;
    }
    function CreateTokens(uint256 _value) restricted {
        totalSupply += _value;
        balances[owner] += _value;
        Transfer(address(this), owner, _value);
    }
    function DonateToOwner(uint256 _value) returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[owner] += _value;
            Transfer(msg.sender, owner, _value);
            return true;
        } else { return false; }
    }


}
