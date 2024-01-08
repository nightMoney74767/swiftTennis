import XCTest

class TiebreakTests : XCTestCase {
    var tiebreak: Tiebreak!
    
    override func setUp() {
        super.setUp()
        tiebreak = Tiebreak()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddPointToPlayer1() {
        var result = ""
        
        tiebreak.addPointToPlayer1()
        result = tiebreak.player1Score()
        XCTAssertEqual(result, "1", "Player 1 score tiebreak to 1")
        
        tiebreak.addPointToPlayer1()
        result = tiebreak.player1Score()
        XCTAssertEqual(result, "2", "Player 1 score tiebreak to 2")
        
        tiebreak.addPointToPlayer1()
        result = tiebreak.player1Score()
        XCTAssertEqual(result, "3", "Player 1 score tiebreak to 3")
        
        tiebreak.addPointToPlayer1()
        result = tiebreak.player1Score()
        XCTAssertEqual(result, "4", "Player 1 score tiebreak to 4")
        
        tiebreak.addPointToPlayer1()
        result = tiebreak.player1Score()
        XCTAssertEqual(result, "5", "Player 1 score tiebreak to 5")
    }
    
    func testAddPointToPlayer2() {
        var result = ""
        
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Score()
        XCTAssertEqual(result, "1", "Player 2 score tiebreak to 1")
        
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Score()
        XCTAssertEqual(result, "2", "Player 2 score tiebreak to 2")
        
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Score()
        XCTAssertEqual(result, "3", "Player 2 score tiebreak to 3")
        
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Score()
        XCTAssertEqual(result, "4", "Player 2 score tiebreak to 4")
        
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Score()
        XCTAssertEqual(result, "5", "Player 2 score tiebreak to 5")
    }
    
    func testPlayer1Score() {
        XCTAssertEqual(tiebreak.player1Score(), "0", "Player 1 has scored 0 tiebreaks")
        
        tiebreak.addPointToPlayer1()
        XCTAssertEqual(tiebreak.player1Score(), "1", "Player 1 has scored 1 tiebreak")
        
        tiebreak.addPointToPlayer1()
        XCTAssertEqual(tiebreak.player1Score(), "2", "Player 1 has scored 2 tiebreaks")
    }
    
    func testPlayer2core() {
        XCTAssertEqual(tiebreak.player2Score(), "0", "Player 2 has scored 0 tiebreaks")
        
        tiebreak.addPointToPlayer2()
        XCTAssertEqual(tiebreak.player2Score(), "1", "Player 2 has scored 1 tiebreak")
        
        tiebreak.addPointToPlayer2()
        XCTAssertEqual(tiebreak.player2Score(), "2", "Player 2 has scored 2 tiebreaks")
    }
    
    func testPlayer1Won() {
        var result = false
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        result = tiebreak.player1Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        result = tiebreak.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the tiebreak")
        
        tiebreak.reset()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        result = tiebreak.player1Won()
        XCTAssertEqual(result, false, "Player 2 wins the tiebreak")
        
        tiebreak.reset()
        for _ in 0...5 {
            tiebreak.addPointToPlayer1()
        }
        
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        result = tiebreak.player1Won()
        XCTAssertEqual(result, false, "Player 2 needs one more game to win the tiebreak")
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        for _ in 0...5 {
            tiebreak.addPointToPlayer2()
        }
        result = tiebreak.player1Won()
        XCTAssertEqual(result, false, "Player 1 needs one more game to win the tiebreak")
    }
    
    func testPlayer2Won() {
        var result = false
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        result = tiebreak.player2Won()
        XCTAssertEqual(result, false, "Player 1 wins the tiebreak")
        
        tiebreak.reset()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        result = tiebreak.player2Won()
        XCTAssertEqual(result, true, "Player 2 wins the tiebreak")
        
        tiebreak.reset()
        for _ in 0...5 {
            tiebreak.addPointToPlayer1()
        }
        
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        result = tiebreak.player2Won()
        XCTAssertEqual(result, false, "Player 2 needs one more game to win the tiebreak")
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        for _ in 0...5 {
            tiebreak.addPointToPlayer2()
        }
        result = tiebreak.player2Won()
        XCTAssertEqual(result, false, "Player 1 needs one more game to win the tiebreak")
    }
    
    func testComplete() {
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.complete(), false)
        tiebreak.reset()
        
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.complete(), true)
        tiebreak.reset()
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        XCTAssertEqual(tiebreak.complete(), true)
        tiebreak.reset()
    }
    
    func testGamePointsForPlayer1() {
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 0)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 4)
        
        tiebreak.reset()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 0)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 3)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 5)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer1()
        }
        
        tiebreak.addPointToPlayer2()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer1(), 6)
        tiebreak.reset()
    }
    
    func testGamePointsForPlayer2() {
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 0)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 4)
        
        tiebreak.reset()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        tiebreak.addPointToPlayer2()
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 0)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 3)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        tiebreak.addPointToPlayer1()
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 5)
        
        tiebreak.reset()
        for _ in 0...6 {
            tiebreak.addPointToPlayer2()
        }
        
        tiebreak.addPointToPlayer1()
        
        XCTAssertEqual(tiebreak.gamePointsForPlayer2(), 6)
        tiebreak.reset()
    }
}
