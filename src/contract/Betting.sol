pragma solidity ^0.4.18;


// 배포소유자만 호출가능
contract Ownable {
    address owner;
    
    // 컨트랙트 생성자 주소가 저장
    function Ownable() public {
        owner = msg.sender;
    }
    
    modifier Owned {
        // 현재 접근자가 소유자가 아니면 throw
        require(msg.sender == owner);
        _;
    }
    
}

contract Mortal is Ownable {
    // 컨트랙트의 생성자만이 호출가능, 컨트랙트가 소멸시 펀드를 되돌려준다.
    function kill() public Owned {
        selfdestruct(owner);
    }
    
}

contract Betting is Mortal {
    // 상태변수
    uint minBet;  // 최소 배당액
    uint winRate; // 배당률
    uint winNum = random();
    
    event Won(bool _result, uint _amount);
    
    function Betting(uint _minBet, uint _winRate) payable public {
        require(_minBet > 0);
        require(_winRate <= 100);
        
        minBet = _minBet;
        winRate = _winRate;
    }
    
    // fallback revert() 직접적인 금액 전송을 막음.
    function() public {
        revert();
    }
    
    function bet(uint _num) payable public {
        require(_num > 0 && _num <= 5);
        require(msg.value >= minBet);
        
        
        
        if (_num == winNum) {
            uint amtWon = msg.value * (100 - winRate) / 10;
            if (!msg.sender.send(amtWon)) {
                revert();
            }
        } else {
            Won(false, 0);
        }
    }
    
    function getBalance() Owned public view returns(uint) {
        return address(this).balance;
    }
    
    function random() public view returns (uint) {
        return uint(keccak256(block.difficulty, block.number, now)) % 5 + 1;
    }
}