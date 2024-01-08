import XCTest

class ViewControllerTests : XCTestCase {
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdateExternalLabels() {
        var result = ""
        var expected = ""
        
        // No tiebreak (game score of 2-2)
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        
        result = viewController.updateExternalLabel(test: true)
        expected = "UoC Tennis Tourney 2023 \n ---------------- \n Players: Player 1 VS Player 2 \n Sets: 1 - 1 \n Games: 2 - 2 \n Points: 15 - 30"
        XCTAssertEqual(result, expected, "External display label correct")
        
        viewController.match.reset()
        viewController.set.reset()
        
        // Tiebreak (game score of 6-6)
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        
        for _ in 0...5 {
            viewController.set.addPointToPlayer1()
            viewController.set.addPointToPlayer2()
        }
        
        for _ in 0...2 {
            viewController.tiebreak.addPointToPlayer1()
            viewController.tiebreak.addPointToPlayer2()
        }
        
        result = viewController.updateExternalLabel(test: true)
        expected = "UoC Tennis Tourney 2023 \n ---------------- \n Players: Player 1 VS Player 2 \n Sets: 1 - 1 \n Games: 6 - 6 \n Points: 3 - 3"
        XCTAssertEqual(result, expected, "External display label correct")
    }
    
    func testDisconnectDisplay() {
        viewController.disconnectDisplay(test: true)
        
        XCTAssertEqual(viewController.externalWindow, nil)
        XCTAssertEqual(viewController.externalWindowView, nil)
    }
    
    func testSetupExternalDisplay() {
        var result = false
        
        if (UIScreen.screens.count < 2) {
            // No external display
            result = viewController.setupExternalDisplay(test: true)
            XCTAssertEqual(result, false)
        } else {
            // External display attached
            result = viewController.setupExternalDisplay(test: true)
            XCTAssertEqual(result, true)
        }
    }
    
    func testEndGame() {
        var result = ""
        var expected = ""
        
        // Player 1 victory
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        
        result = viewController.endGame(winner: 1, test: true)
        expected = "Player 1 has won the match with a set score of 3-2. Please tap Restart to play a new match"
        XCTAssertEqual(result, expected, "Alert message incorrect")
        viewController.match.reset()
        
        // Player 2 victory
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        
        result = viewController.endGame(winner: 1, test: true)
        expected = "Player 1 has won the match with a set score of 2-3. Please tap Restart to play a new match"
        XCTAssertEqual(result, expected, "Alert message incorrect")
        viewController.match.reset()
    }
    
    func testPlayAudio() {
        let result = viewController.playAudio()
        XCTAssertEqual(result, true, "Audio has not been setup correctly")
    }
    
    func testSwitchServer() {
        var result = false
        
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        result = viewController.switchServer(secondPoint: false, test: true)
        XCTAssertEqual(result, false)
        
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        result = viewController.switchServer(secondPoint: false, test: true)
        XCTAssertEqual(result, false)
        viewController.game.reset()
        
        for _ in 0...5 {
            viewController.set.addPointToPlayer1()
            viewController.set.addPointToPlayer2()
        }
        
        result = viewController.switchServer(secondPoint: false, test: true)
        XCTAssertEqual(result, true)
        result = viewController.switchServer(secondPoint: true, test: true)
        XCTAssertEqual(result, false)
    }
    
    func testCallNewBallsPlease() {
        var result = 0
        viewController.newBallsWhen = 7
        
        viewController.games = 1
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 2
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 3
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 4
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 5
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 6
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 7
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 1, "Speech function should be called")
        
        viewController.newBallsWhen = 9
        viewController.games = 6
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 7
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 8
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 0, "Speech function should not be called")
        
        viewController.games = 9
        result = viewController.callNewBallsPlease()
        XCTAssertEqual(result, 1, "Speech function should be called")
        
    }
    
    func testIsTiebreak() {
        var result = false
        
        // Tests for any set other than the fifth set
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        
        result = viewController.isTiebreak()
        XCTAssertEqual(result, false, "Tiebreak should not apply")
        viewController.set.reset()
        
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        
        result = viewController.isTiebreak()
        XCTAssertEqual(result, false, "Tiebreak should not apply")
        viewController.set.reset()
        
        // Tests for the fifth set
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        
        result = viewController.isTiebreak()
        XCTAssertEqual(result, false, "Tiebreak should not apply")
        viewController.set.reset()
        
        for _ in 0...5 {
            viewController.set.addPointToPlayer1()
            viewController.set.addPointToPlayer2()
        }
        
        result = viewController.isTiebreak()
        XCTAssertEqual(result, true, "Tiebreak should apply")
        viewController.set.reset()
    }
    
    func testMarkFourPointsOrAdvantage() {
        var result = 0
        
        // Player 1
        viewController.game.addPointToPlayer1()
        result = viewController.markFourPointsOrAdvantage(player: 1, test: true)
        XCTAssertEqual(result, 4)
        viewController.game.addPointToPlayer1()
        result = viewController.markFourPointsOrAdvantage(player: 1, test: true)
        XCTAssertEqual(result, 4)
        viewController.game.addPointToPlayer1()
        result = viewController.markFourPointsOrAdvantage(player: 1, test: true)
        XCTAssertEqual(result, 2)
        viewController.game.addPointToPlayer1()
        result = viewController.markFourPointsOrAdvantage(player: 1, test: true)
        XCTAssertEqual(result, 1)
        
        // Player 2
        viewController.game.reset()
        viewController.game.addPointToPlayer2()
        result = viewController.markFourPointsOrAdvantage(player: 2, test: true)
        XCTAssertEqual(result, 8)
        viewController.game.addPointToPlayer2()
        result = viewController.markFourPointsOrAdvantage(player: 2, test: true)
        XCTAssertEqual(result, 8)
        viewController.game.addPointToPlayer2()
        result = viewController.markFourPointsOrAdvantage(player: 2, test: true)
        XCTAssertEqual(result, 6)
        viewController.game.addPointToPlayer2()
        result = viewController.markFourPointsOrAdvantage(player: 2, test: true)
        XCTAssertEqual(result, 5)
        
        // Both at 40
        viewController.game.reset()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        result = viewController.markFourPointsOrAdvantage(player: 2, test: true)
        XCTAssertEqual(result, 7)
        result = viewController.markFourPointsOrAdvantage(player: 1, test: true)
        XCTAssertEqual(result, 3)
    }
    
    func testMarkAboutToWinTiebreak() {
        var result = 0
        
        // Player 1
        viewController.tiebreak.addPointToPlayer1()
        result = viewController.markAboutToWinTiebreak(player: 1, test: true)
        XCTAssertEqual(result, 2)
        
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        result = viewController.markAboutToWinTiebreak(player: 1, test: true)
        XCTAssertEqual(result, 1)
        viewController.tiebreak.reset()
        
        // Player 2
        viewController.tiebreak.addPointToPlayer2()
        result = viewController.markAboutToWinTiebreak(player: 2, test: true)
        XCTAssertEqual(result, 4)
        
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        result = viewController.markAboutToWinTiebreak(player: 2, test: true)
        XCTAssertEqual(result, 3)
        viewController.tiebreak.reset()
        
        // Both players with same number of tiebreak points
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer1()
        viewController.tiebreak.addPointToPlayer2()
        viewController.tiebreak.addPointToPlayer2()
        
        result = viewController.markAboutToWinTiebreak(player: 0, test: true)
        XCTAssertEqual(result, 5)
        viewController.tiebreak.reset()
    }
    
    func testMarkAboutToWinSet() {
        var result = 0
        
        // Player 1
        viewController.set.addPointToPlayer1()
        result = viewController.markAboutToWinSet(player: 1, test: true)
        XCTAssertEqual(result, 2)
        
        for _ in 0...4 {
            viewController.set.addPointToPlayer1()
        }
        
        result = viewController.markAboutToWinSet(player: 1, test: true)
        XCTAssertEqual(result, 1)
        viewController.set.reset()
        
        // Player 2
        viewController.set.addPointToPlayer2()
        result = viewController.markAboutToWinSet(player: 2, test: true)
        XCTAssertEqual(result, 4)
        
        for _ in 0...4 {
            viewController.set.addPointToPlayer2()
        }
        
        result = viewController.markAboutToWinSet(player: 2, test: true)
        XCTAssertEqual(result, 3)
        viewController.set.reset()
        
        // Both players with same number of sets
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        result = viewController.markAboutToWinSet(player: 0, test: true)
        XCTAssertEqual(result, 5)
    }
    
    func testMarkAboutToWinMatch() {
        var result = 0
        
        // Player 1
        viewController.match.addPointToPlayer1()
        result = viewController.markAboutToWinMatch(player: 1, test: true)
        XCTAssertEqual(result, 2, "1 set")
        
        viewController.match.addPointToPlayer1()
        result = viewController.markAboutToWinMatch(player: 1, test: true)
        XCTAssertEqual(result, 2, "2 sets")
        
        viewController.match.addPointToPlayer1()
        result = viewController.markAboutToWinMatch(player: 1, test: true)
        XCTAssertEqual(result, 1, "3 sets")
        
        viewController.match.addPointToPlayer1()
        result = viewController.markAboutToWinMatch(player: 1, test: true)
        XCTAssertEqual(result, 1, "4 sets")
        
        viewController.match.addPointToPlayer1()
        result = viewController.markAboutToWinMatch(player: 1, test: true)
        XCTAssertEqual(result, 1, "5 sets")
        viewController.match.reset()
        
        // Player 2
        viewController.match.addPointToPlayer2()
        result = viewController.markAboutToWinMatch(player: 2, test: true)
        XCTAssertEqual(result, 4, "1 set")
        
        viewController.match.addPointToPlayer2()
        result = viewController.markAboutToWinMatch(player: 2, test: true)
        XCTAssertEqual(result, 4, "2 sets")
        
        viewController.match.addPointToPlayer2()
        result = viewController.markAboutToWinMatch(player: 2, test: true)
        XCTAssertEqual(result, 3, "3 sets")
        
        viewController.match.addPointToPlayer2()
        result = viewController.markAboutToWinMatch(player: 2, test: true)
        XCTAssertEqual(result, 3, "4 sets")
        
        viewController.match.addPointToPlayer2()
        result = viewController.markAboutToWinMatch(player: 2, test: true)
        XCTAssertEqual(result, 3, "5 sets")
        viewController.match.reset()
    }
    
    func testAddPointToPlayer1() {
        // Determine if a point is added
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "15")
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "30")
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "40")
        XCTAssertEqual(viewController.set.player1Score(), "0")
        viewController.addPointToPlayer1(test: true)
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.set.player1Score(), "1")
        XCTAssertEqual(viewController.match.player1Score(), "0")
        
        // Add a set point and six game points
        viewController.match.addPointToPlayer1()
        
        for _ in 0...4 {
            viewController.set.addPointToPlayer1()
        }
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "15")
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "30")
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "40")
        XCTAssertEqual(viewController.set.player1Score(), "6")
        viewController.addPointToPlayer1(test: true)
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.match.player1Score(), "2")
    }
    
    func testAddPointToPlayer1TieBreak() {
        for _ in 0...5 {
            viewController.set.addPointToPlayer1()
            viewController.set.addPointToPlayer2()
        }
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "1")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "2")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "3")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "4")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "5")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "6")
        
        viewController.addPointToPlayer1(test: true)
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player1Score(), "7")
    }
    
    func testAddPointToPlayer2() {
        // Determine if a point is added
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "15")
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "30")
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "40")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        viewController.addPointToPlayer2(test: true)
        
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "1")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        // Add two set points and six game points
        viewController.match.addPointToPlayer2()
        
        for _ in 0...4 {
            viewController.set.addPointToPlayer2()
        }
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "15")
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "30")
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "40")
        XCTAssertEqual(viewController.set.player2Score(), "6")
        viewController.addPointToPlayer2(test: true)
        
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "2")
    }
    
    func testAddPointToPlayer2TieBreak() {
        for _ in 0...5 {
            viewController.set.addPointToPlayer1()
            viewController.set.addPointToPlayer2()
        }
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "1")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "2")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "3")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "4")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "5")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "6")
        
        viewController.addPointToPlayer2(test: true)
        XCTAssertEqual(viewController.game.player2Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "7")
    }
    
    func testResetMatchStats() {
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        
        for _ in 0...4 {
            viewController.set.addPointToPlayer1()
        }
        
        for _ in 0...3 {
            viewController.set.addPointToPlayer2()
        }
        
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        
        viewController.resetMatchStats()
        XCTAssertEqual(viewController.match.player1Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.game.player2Score(), "0")
        
        XCTAssertEqual(viewController.tiebreak.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "0")
    }
    
    func testResetMatchStats2() {
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        
        viewController.game.addPointToPlayer2()
        
        viewController.resetMatchStats()
        XCTAssertEqual(viewController.match.player1Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.game.player2Score(), "0")
        
        XCTAssertEqual(viewController.tiebreak.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "0")
    }
    
    func testResetMatchStats3() {
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        viewController.match.addPointToPlayer2()
        
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        viewController.set.addPointToPlayer2()
        
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer1()
        
        viewController.resetMatchStats()
        XCTAssertEqual(viewController.match.player1Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.game.player2Score(), "0")
        
        XCTAssertEqual(viewController.tiebreak.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "0")
    }
    
    func testResetMatchStats4() {
        viewController.match.addPointToPlayer1()
        viewController.match.addPointToPlayer2()
        
        viewController.set.addPointToPlayer1()
        viewController.set.addPointToPlayer2()
        
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        viewController.game.addPointToPlayer2()
        
        viewController.resetMatchStats()
        XCTAssertEqual(viewController.match.player1Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.game.player2Score(), "0")
        
        XCTAssertEqual(viewController.tiebreak.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "0")
    }
    
    func testResetMatchStats5() {
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        viewController.game.addPointToPlayer1()
        
        viewController.resetMatchStats()
        XCTAssertEqual(viewController.match.player1Score(), "0")
        XCTAssertEqual(viewController.match.player2Score(), "0")
        
        XCTAssertEqual(viewController.set.player1Score(), "0")
        XCTAssertEqual(viewController.set.player2Score(), "0")
        
        XCTAssertEqual(viewController.game.player1Score(), "0")
        XCTAssertEqual(viewController.game.player2Score(), "0")
        
        XCTAssertEqual(viewController.tiebreak.player1Score(), "0")
        XCTAssertEqual(viewController.tiebreak.player2Score(), "0")
    }
}
