class Game: Scorable {
    // Variables for player game scores
    internal var playerOneScore: Int = 0
    internal var playerTwoScore: Int = 0
    
    // Marked as private using internal
    internal func reset() {
        playerOneScore = 0
        playerTwoScore = 0
    }
    
    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    func addPointToPlayer1(){
        // If in deuce and not in Advantage, set player 1 score to Advantage
        if (playerOneScore == 3 && playerTwoScore == 3) {
            playerOneScore = 4
        } else if (playerTwoScore == 4) {
            // If other player has Advantage, set scores to 40-40
            playerTwoScore = 3
        } else {
            playerOneScore += 1
        }
    }
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
        // If in deuce and not in Advantage, set player 1 score to Advantage
        if (playerOneScore == 3 && playerTwoScore == 3) {
            playerTwoScore = 4
        } else if (playerOneScore == 4) {
            // If other player has Advantage, set scores to 40-40
            playerOneScore = 3
        } else {
            playerTwoScore += 1
        }
    }

    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        switch(playerOneScore) {
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "A"
        default:
            return "0"
        }
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        switch(playerTwoScore) {
        case 0:
            return "0"
        case 1:
            return "15"
        case 2:
            return "30"
        case 3:
            return "40"
        case 4:
            return "A"
        default:
            return "0"
        }
    }
    
    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        if ((playerOneScore == 3 && playerTwoScore < 3) || playerOneScore == 4) {
            return true
        }
        return false
    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        if ((playerTwoScore == 3 && playerOneScore < 3) || playerTwoScore == 4) {
            return true
        }
        return false
    }
    
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        if (player1Won() || player2Won()) {
            return true
        }
        return false
    }
    
    /**
     If player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     */
    func gamePointsForPlayer1() -> Int{
        var difference = 0
        let winNextPoint = player1Won()
        if (playerOneScore > playerTwoScore && winNextPoint) {
            difference = playerOneScore - playerTwoScore
        }
        return difference
    }
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        var difference = 0
        let winNextPoint = player2Won()
        if (playerTwoScore > playerOneScore && winNextPoint) {
            difference = playerTwoScore - playerOneScore
        }
        return difference
    }
    
}

