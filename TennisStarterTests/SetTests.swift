import XCTest

class SetTests : XCTestCase {
    var set: Set!
    
    override func setUp() {
        super.setUp()
        set = Set()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddSetPointToPlayerOne() {
        var result = ""
        
        set.addPointToPlayer1()
        result = set.player1Score()
        XCTAssertEqual(result, "1", "Player 1 score set to 1")
        
        set.addPointToPlayer1()
        result = set.player1Score()
        XCTAssertEqual(result, "2", "Player 1 score set to 2")
        
        set.addPointToPlayer1()
        result = set.player1Score()
        XCTAssertEqual(result, "3", "Player 1 score set to 3")
        
        set.addPointToPlayer1()
        result = set.player1Score()
        XCTAssertEqual(result, "4", "Player 1 score set to 4")
        
        set.addPointToPlayer1()
        result = set.player1Score()
        XCTAssertEqual(result, "5", "Player 1 score set to 5")
    }
    
    func testAddSetPointToPlayerTwo() {
        var result = ""
        
        set.addPointToPlayer2()
        result = set.player2Score()
        XCTAssertEqual(result, "1", "Player 2 score set to 1")
        
        set.addPointToPlayer2()
        result = set.player2Score()
        XCTAssertEqual(result, "2", "Player 2 score set to 2")
        
        set.addPointToPlayer2()
        result = set.player2Score()
        XCTAssertEqual(result, "3", "Player 2 score set to 3")
        
        set.addPointToPlayer2()
        result = set.player2Score()
        XCTAssertEqual(result, "4", "Player 2 score set to 4")
        
        set.addPointToPlayer2()
        result = set.player2Score()
        XCTAssertEqual(result, "5", "Player 2 score set to 5")
    }
    
    func testGetPlayerOneSetScore() {
        XCTAssertEqual(set.player1Score(), "0", "Player 1 has scored 0 sets")
        
        set.addPointToPlayer1()
        XCTAssertEqual(set.player1Score(), "1", "Player 1 has scored 1 set")
        
        set.addPointToPlayer1()
        XCTAssertEqual(set.player1Score(), "2", "Player 1 has scored 2 sets")
    }
    
    func testGetPlayerTwoSetScore() {
        XCTAssertEqual(set.player2Score(), "0", "Player 2 has scored 0 sets")
        
        set.addPointToPlayer2()
        XCTAssertEqual(set.player2Score(), "1", "Player 2 has scored 1 set")
        
        set.addPointToPlayer2()
        XCTAssertEqual(set.player2Score(), "2", "Player 2 has scored 2 sets")
    }
    
    func testPlayer1Won() {
        var result = false
        
        result = set.player1Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")

        for _ in 0...5 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        result = set.player1Won()
        XCTAssertEqual(result, true, "Player 1 nwins the set")

        set.reset()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        for _ in 0...5 {
            set.addPointToPlayer2()
        }
        result = set.player1Won()
        XCTAssertEqual(result, false, "Player 2 wins the set")

        set.reset()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        for _ in 0...5 {
            set.addPointToPlayer1()
        }
        result = set.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the set")

        set.reset()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        result = set.player1Won()
        XCTAssertEqual(result, false, "No winner has been decided")
    }
    
    func testPlayer2Won() {
        var result = false
        
        result = set.player1Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")

        for _ in 0...5 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        result = set.player2Won()
        XCTAssertEqual(result, false, "Player 1 nwins the set")

        set.reset()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        for _ in 0...5 {
            set.addPointToPlayer2()
        }
        result = set.player2Won()
        XCTAssertEqual(result, true, "Player 2 wins the set")

        set.reset()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        for _ in 0...5 {
            set.addPointToPlayer1()
        }
        result = set.player2Won()
        XCTAssertEqual(result, false, "Player 1 wins the set")

        set.reset()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        result = set.player2Won()
        XCTAssertEqual(result, false, "No winner has been decided")
    }
    
    func testComplete() {
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.complete(), false)
        set.reset()
        
        for _ in 0...6 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.complete(), true)
        set.reset()
        
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        for _ in 0...5 {
            set.addPointToPlayer2()
        }
        
        XCTAssertEqual(set.complete(), true)
        set.reset()
    }
    
    func testGamePointsForPlayer1() {
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 0)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 4)
        
        set.reset()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        for _ in 0...4 {
            set.addPointToPlayer2()
        }
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 0)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 3)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 5)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer1()
        }
        
        set.addPointToPlayer2()
        
        XCTAssertEqual(set.gamePointsForPlayer1(), 6)
        set.reset()
    }
    
    func testGamePointsForPlayer2() {
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 0)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer2()
        }
        
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 4)
        
        set.reset()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        set.addPointToPlayer2()
        
        for _ in 0...4 {
            set.addPointToPlayer1()
        }
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 0)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer2()
        }
        
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 3)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer2()
        }
        
        set.addPointToPlayer1()
        set.addPointToPlayer1()
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 5)
        
        set.reset()
        for _ in 0...6 {
            set.addPointToPlayer2()
        }
        
        set.addPointToPlayer1()
        
        XCTAssertEqual(set.gamePointsForPlayer2(), 6)
        set.reset()
    }
}
