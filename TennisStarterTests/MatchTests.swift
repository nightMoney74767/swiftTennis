import XCTest

class MatchTests : XCTestCase {
    var match: Match!
    
    override func setUp() {
        super.setUp()
        match = Match()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddPointToPlayer1() {
        var result = ""
        
        match.addPointToPlayer1()
        result = match.player1Score()
        XCTAssertEqual(result, "1", "Player 1 score set to 1")
        
        match.addPointToPlayer1()
        result = match.player1Score()
        XCTAssertEqual(result, "2", "Player 1 score set to 2")
        
        match.addPointToPlayer1()
        result = match.player1Score()
        XCTAssertEqual(result, "3", "Player 1 score set to 3")
    }
    
    func testAddPointToPlayer2() {
        var result = ""
        
        match.addPointToPlayer2()
        result = match.player2Score()
        XCTAssertEqual(result, "1", "Player 2 score set to 1")
        
        match.addPointToPlayer2()
        result = match.player2Score()
        XCTAssertEqual(result, "2", "Player 2 score set to 2")
        
        match.addPointToPlayer2()
        result = match.player2Score()
        XCTAssertEqual(result, "3", "Player 2 score set to 3")
    }
    
    func testPlayer1Score() {
        XCTAssertEqual(match.player1Score(), "0", "Player 1 has scored 0 matchs")
        
        match.addPointToPlayer1()
        XCTAssertEqual(match.player1Score(), "1", "Player 1 has scored 1 match")
        
        match.addPointToPlayer1()
        XCTAssertEqual(match.player1Score(), "2", "Player 1 has scored 2 matchs")
    }
    
    func testPlayer2Score() {
        XCTAssertEqual(match.player2Score(), "0", "Player 2 has scored 0 matchs")
        
        match.addPointToPlayer2()
        XCTAssertEqual(match.player2Score(), "1", "Player 2 has scored 1 match")
        
        match.addPointToPlayer2()
        XCTAssertEqual(match.player2Score(), "2", "Player 2 has scored 2 matchs")
    }
    
    func testPlayer1Won() {
        var result = false
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        result = match.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the match")
        
        match.reset()
        for _ in 0...3 {
            match.addPointToPlayer1()
        }
        
        match.addPointToPlayer2()
        result = match.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        
        for _ in 0...3 {
            match.addPointToPlayer2()
        }
        result = match.player1Won()
        XCTAssertEqual(result, false, "Player 2 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player1Won()
        XCTAssertEqual(result, false, "Player 2 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player1Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")
        
        match.reset()
        for _ in 0...4 {
            match.addPointToPlayer1()
        }
        
        result = match.player1Won()
        XCTAssertEqual(result, true, "Player 1 wins the match")
    }
    
    func testPlayer2Won() {
        var result = false
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        result = match.player2Won()
        XCTAssertEqual(result, false, "Player 1 wins the match")
        
        match.reset()
        for _ in 0...3 {
            match.addPointToPlayer1()
        }
        
        match.addPointToPlayer2()
        result = match.player2Won()
        XCTAssertEqual(result, false, "Player 1 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        
        for _ in 0...3 {
            match.addPointToPlayer2()
        }
        result = match.player2Won()
        XCTAssertEqual(result, true, "Player 2 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player2Won()
        XCTAssertEqual(result, true, "Player 2 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player2Won()
        XCTAssertEqual(result, false, "Player 1 wins the match")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        result = match.player2Won()
        XCTAssertEqual(result, false, "Winner has not yet been decided")
        
        match.reset()
        for _ in 0...3 {
            match.addPointToPlayer1()
        }
        
        result = match.player2Won()
        XCTAssertEqual(result, false, "Player 2 wins the match")
    }
    
    func testCheckFifthSet() {
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), true, "Fifth set")
        
        match.reset()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), false, "Not the fifth set")
        
        match.reset()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        
        match.addPointToPlayer1()
        XCTAssertEqual(match.fifthSet(), true, "Not the fifth set")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), true, "Fifth set")
        
        match.reset()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), false, "Not the fifth set")
        
        match.reset()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), false, "Not the fifth set")
        
        match.reset()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        XCTAssertEqual(match.fifthSet(), false, "Not the fifth set")
    }
    
    func testComplete() {
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), false)
        match.reset()
        
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), true)
        match.reset()
        
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), true)
        match.reset()
        
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), true)
        match.reset()
        
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), true)
        match.reset()
        
        match.addPointToPlayer1()
        
        match.addPointToPlayer2()
        
        XCTAssertEqual(match.complete(), false)
        match.reset()
        
    }
}
