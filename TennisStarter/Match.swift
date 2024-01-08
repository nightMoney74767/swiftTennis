import Foundation
class Match: Scorable {
    // Current set scores with a match
    internal var playerOneScore: Int = 0
    internal var playerTwoScore: Int = 0
    
    func reset() {
        playerOneScore = 0
        playerTwoScore = 0
    }
    
    func addPointToPlayer1() {
        playerOneScore += 1
    }
    
    func addPointToPlayer2() {
        playerTwoScore += 1
    }
    
    func player1Score() -> String {
        return String(playerOneScore)
    }
    
    func player2Score() -> String {
        return String(playerTwoScore)
    }
    
    func player1Won() -> Bool {
        // Player immediately wins match with 3 or 4 sets
        if (playerOneScore == 3 && playerTwoScore <= 2) {
            return true
        }
        
        if (playerOneScore == 4 && playerTwoScore <= 1) {
            return true
        }
        
        if (playerOneScore == 5 && playerTwoScore == 0) {
            return true
        }
        return false
    }
    
    func player2Won() -> Bool {
        // Player immediately wins match with 3 or 4 sets
        if (playerTwoScore == 3 && playerOneScore <= 2) {
            return true
        }
        
        if (playerTwoScore == 4 && playerOneScore <= 1) {
            return true
        }
        
        if (playerTwoScore == 5 && playerOneScore == 0) {
            return true
        }
        return false
    }
    
    func complete() -> Bool {
        if (player1Won() || player2Won()) {
            return true
        }
        return false
    }
    
    // Determine if the fifth set is being played
    func fifthSet() -> Bool {
        if ((playerOneScore + playerTwoScore) == 4) {
            return true
        }
        return false
    }
}
