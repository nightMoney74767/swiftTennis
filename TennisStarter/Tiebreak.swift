import Foundation
class Tiebreak : Scorable {
    // Current tiebreak scores inherited from game class
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
        if (playerOneScore > playerTwoScore) {
            if (playerOneScore >= 7 && ((playerOneScore - playerTwoScore) >= 2)) {
                return true
            }
        }
        return false
    }
    
    func player2Won() -> Bool {
        if (playerTwoScore > playerOneScore) {
            if (playerTwoScore >= 7 && ((playerTwoScore - playerOneScore) >= 2)) {
                return true
            }
        }
        return false
    }
    
    func complete() -> Bool {
        if (player1Won() || player2Won()) {
            return true
        }
        return false
    }
    
    func gamePointsForPlayer1() -> Int {
        var difference = 0
        let winNextPoint = player1Won()
        if (playerOneScore > playerTwoScore && winNextPoint) {
            difference = playerOneScore - playerTwoScore
        }
        return difference
    }
    
    func gamePointsForPlayer2 () -> Int {
        var difference = 0
        let winNextPoint = player2Won()
        if (playerTwoScore > playerOneScore && winNextPoint) {
            difference = playerTwoScore - playerOneScore
        }
        return difference
    }
}
