/** Hello Poaple! This contract was created by itsN1X.**
 **They can be found at telegram or twitter as @itsN1X**
 **===================================================**
 **Send them your beloved digital collectibles & art!!**
 **Address: 0xD0f79B71A8ffB7f70392630f8BFc900fcA27af42**
 *******************************************************
 * This contract's purpose is to serve as Wrapped P.O.A.
 * The SWAPOA might be the first Decentralized Exchange.
 *-----------------------------------------------------+
 * This contract takes POA and gives back WRAPOA tokens.
 * The WRAPOA are similar to WETH & are converted @ 1:1.
 * To get WRAPOA send some POA to this contract address.
 * To get POA back, first "approve" this address (call).
 * Secondly, call the "withdraw" function of S.Contract.
 * Enter the amount (1 POA= 10^18 POA) desired as input.
 *L..................................................../
 * This contract was made on Day8990 by itsN1X with ++♡
 * http://github.com/SWAPOA/WRAPOA http://9xo.github.io*
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++
 * SPDX-License-Identifier: Share-it-with-itsN1X-online;
 *^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

pragma solidity ^0.6.0;

contract WRAPOA {
    string public name     = "Wrapped POA";
    string public symbol   = "WRAPOA";
    uint8  public decimals = 18;

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    mapping (address => uint)                       public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    receive() external payable {
        deposit();
    }
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint wad) public {
        require(balanceOf[msg.sender] >= wad);
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    function totalSupply() public view returns (uint) {
        return address(this).balance;
    }

    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(address src, address dst, uint wad)
        public
        returns (bool)
    {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);

        return true;
    }
}
