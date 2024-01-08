import Foundation

protocol Scorable {
    // Scores for each player
    var playerOneScore: Int { get set }
    var playerTwoScore: Int { get set }
    
    // Reset scores
    func reset()
    
    // Add a point to player 1
    func addPointToPlayer1()
    
    // Add a point to player 2
    func addPointToPlayer2()
    
    // Get player 1 score
    func player1Score() -> String
    
    // Get player 1 score
    func player2Score() -> String
    
    // Determine if player 1 has won
    func player1Won() -> Bool
    
    // Determine if player 2 has won
    func player2Won() -> Bool
    
    // Determine if a game, set, match or tiebreak is has finished
    func complete() -> Bool
}
