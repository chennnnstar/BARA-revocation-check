pragma solidity >=0.8.2 <0.9.0;

contract VerificationContract {
    mapping(bytes32 => bytes32) private ckf;
    mapping(bytes32 => bytes32) private rl;
    
    function verify(bytes32 rid) public view returns (bool) {
        bytes32 h1 = hash(rid);
        bytes32 h3 = fingerprint(rid);
        bytes32 h2 = h1 ^ hash(h3);
        
        if (rl[h1] == h3 || rl[h2] == h3) {
            return true;
        }
        
        if (ckf[h1] == h3 || ckf[h2] == h3) {
            return false;
        }
        
        return true;
    }
    
    function hash(bytes32 data) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(data));
    }
    
    function fingerprint(bytes32 data) private pure returns (bytes32) {
        return hash(data);
    }
    
    function addToCKF(bytes32 key, bytes32 value) public {
        ckf[key] = value;
    }
    
    function addToRL(bytes32 key, bytes32 value) public {
        rl[key] = value;
    }
}
