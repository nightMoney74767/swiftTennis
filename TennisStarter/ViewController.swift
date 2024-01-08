import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController {
    // Instances of classes
    var match = Match()
    var set = Set()
    var game = Game()
    var tiebreak = Tiebreak()
    
    var secondPoint = false
    var server = 1
    var firstTiebreakServer = 0
    var games = 0
    var newBallsWhen = 7
    
    let speechSynthesiser = AVSpeechSynthesizer()
    
    // Adapted from Apple Developer Forums (OOPer, 2020) and StackOverflow (working dog support Ukraine, 2023)
    var audioPlayer: AVAudioPlayer?
    // End of adapted code
    
    var externalWindow: UIWindow?
    var externalWindowView: UIView?
    
    override func viewDidLoad() {
        // Setup labels on app launch
        super.viewDidLoad()
        p1PointsLabel.text = "0"
        p2PointsLabel.text = "0"

        p1GamesLabel.text = "0"
        p2GamesLabel.text = "0"

        p1SetsLabel.text = "0"
        p2SetsLabel.text = "0"

        p1PreviousSetsLabel.text = ""
        p2PreviousSetsLabel.text = ""
        
        p1NameLabel.backgroundColor = UIColor.purple
        p1NameLabel.textColor = UIColor.white
        
        setUpExternalDisplay()
        
        // Inform user that the match has started
        // Adapted from Apple Developer (2023A & 2023B)
        let speechUtterance = AVSpeechUtterance(string: "Welcome")
        speechSynthesiser.speak(speechUtterance)
        // End of adapted code
    }
    
    // Setup an external display which displays match scores
    func setUpExternalDisplay() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupExternalDisplay), name: UIScreen.didConnectNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectDisplay), name: UIScreen.didDisconnectNotification, object: nil)
    }
    
    @objc func disconnectDisplay(test: Bool) {
        externalWindow = nil
        externalWindowView = nil
        
        // Update display status on the IOS view
        if (!test) {
            displayStatus.text = "Not Connected"
            displayStatus.textColor = UIColor.red
        }
    }
    
    var externalDisplayLabel = UILabel()
    
    func updateExternalLabel(test: Bool) -> String {
        var externalLabelText = ""
        if (isTiebreak()) {
            externalLabelText = "UoC Tennis Tourney 2023 \n ---------------- \n Players: Player 1 VS Player 2 \n Sets: \(match.player1Score()) - \(match.player2Score()) \n Games: \(set.player1Score()) - \(set.player2Score()) \n Points: \(tiebreak.player1Score()) - \(tiebreak.player2Score())"
        } else {
            externalLabelText = "UoC Tennis Tourney 2023 \n ---------------- \n Players: Player 1 VS Player 2 \n Sets: \(match.player1Score()) - \(match.player2Score()) \n Games: \(set.player1Score()) - \(set.player2Score()) \n Points: \(game.player1Score()) - \(game.player2Score())"
        }
        
        if (!test) {
            externalLabelText.append("\n History: \(p1PreviousSetsLabel.text ?? "N/A") - \(p2PreviousSetsLabel.text ?? "N/A")")
            externalDisplayLabel.text = externalLabelText
        }
        
        return externalLabelText
    }
    
    func setupExternalLabels() {
        // Setup a label that displays the match scores on the external display as seen on the main view. Adapted from GitHub (andymuncey, 2019)
        externalDisplayLabel.textAlignment = NSTextAlignment.center
        externalDisplayLabel.numberOfLines = 7
        externalDisplayLabel.font = UIFont(name: "Arial", size: 80.0)
        externalDisplayLabel.frame = externalWindowView!.bounds
        // End of adapted code
        
        externalDisplayLabel.textColor = UIColor.white
        
        updateExternalLabel(test: false)
        
        // Add to secondary display
        externalWindowView!.addSubview(externalDisplayLabel)
    }
    
    @objc func setupExternalDisplay(test: Bool) -> Bool {
        if UIScreen.screens.count < 2 {
            return false
        } else {
            let externalScreen = UIScreen.screens[1]
            externalWindow = UIWindow(frame: externalScreen.bounds)
            
            let viewController = UIViewController()
            externalWindow?.rootViewController = viewController
            externalWindow!.screen = externalScreen
            
            externalWindowView = UIView(frame: externalWindow!.frame)
            
            externalWindow!.addSubview(externalWindowView!)
            
            // Open the second window and set the background colour to black
            externalWindow!.isHidden = false
            externalWindow?.backgroundColor = UIColor.black
            
            if (!test) {
                // Configure content
                setupExternalLabels()
                
                // Update display status on the IOS view
                displayStatus.text = "Connected"
                displayStatus.textColor = UIColor.blue
            }
            
            return true
        }
    }
    
    @IBOutlet weak var displayStatus: UILabel!
    
    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    // Function for updating UI labels
    func updateLabels() {
        if (isTiebreak()) {
            p1PointsLabel.text = tiebreak.player1Score()
            p2PointsLabel.text = tiebreak.player2Score()
        } else {
            p1PointsLabel.text = game.player1Score()
            p2PointsLabel.text = game.player2Score()
        }

        p1GamesLabel.text = set.player1Score()
        p2GamesLabel.text = set.player2Score()

        p1SetsLabel.text = match.player1Score()
        p2SetsLabel.text = match.player2Score()
        
        updateExternalLabel(test: false)
    }
    
    // Function that is called when a match ends
    func endGame(winner: Int, test: Bool) -> String {
        // Inform user that the match has ended
        // Adapted from Apple Developer (2023A & 2023B)
        let speechUtterance = AVSpeechUtterance(string: "Match over. Player \(winner) is victorious!")
        speechSynthesiser.speak(speechUtterance)
        // End of adapted code
        
        // Used XCode developer documentation (Apple Developer, 2023C)
        let alertMessage = "Player \(winner) has won the match with a set score of \(match.player1Score())-\(match.player2Score()). Please tap Restart to play a new match"
        if (!test) {
            let alert = UIAlertController(title: "Player \(winner) is Victorious!", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
            p1Button.isEnabled = false
            p2Button.isEnabled = false
        }
        
        resetMatchStats()
        return alertMessage
    }
    
    func playAudio() -> Bool {
        // Play sound.wav file using a try-catch block (Swift Documentation, 2023)
        
        // The AVAudioPlayer is declared as an instance variable
        // Adapted from Apple Developer (2023D & 2023E)
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let soundPath = Bundle.main.url(forResource: "Sound", withExtension: "wav")!
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
            try audioSession.setActive(true)
            // End of adapted code
            audioPlayer = try AVAudioPlayer(contentsOf: soundPath)
            audioPlayer?.volume = 0.3
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    func switchServer(secondPoint: Bool, test: Bool) -> Bool {
        // In a tiebreak, switch server every two points rounds. Otherwise, switch after each game
        if (!isTiebreak() || (isTiebreak() && secondPoint)) {
            if (server == 1) {
                if (!test) {
                    p2NameLabel.backgroundColor = UIColor.purple
                    p2NameLabel.textColor = UIColor.white

                    p1NameLabel.backgroundColor = UIColor.white
                    p1NameLabel.textColor = UIColor.black
                }
                server = 2
            } else {
                if (!test) {
                    p1NameLabel.backgroundColor = UIColor.purple
                    p1NameLabel.textColor = UIColor.white

                    p2NameLabel.backgroundColor = UIColor.white
                    p2NameLabel.textColor = UIColor.black
                }
                server = 1
            }
            
            playAudio()
        }

        if (isTiebreak()) {
            if (secondPoint) {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    func callNewBallsPlease() -> Int {
        if (games == newBallsWhen) {
            // Call 'new balls please' using XCode documentation
            // Adapted from Apple Developer (2023A & 2023B)
            let speechUtterance = AVSpeechUtterance(string: "New balls please")
            speechSynthesiser.speak(speechUtterance)
            // End of adapted code
            
            games = 0
            if (newBallsWhen == 7) {
                newBallsWhen = 9
            }
            return 1
        } else {
            games += 1
            return 0
        }
    }
    
    // Determine if tiebreak is applicable
    func isTiebreak() -> Bool {
        var gamesToTiebreak = "6"
        if (match.fifthSet()) {
            gamesToTiebreak = "12"
        }
        
        if ((set.player1Score() == gamesToTiebreak || set.player2Score() == gamesToTiebreak) && (set.player1Score() == set.player2Score())) {
            return true
        }
        return false
    }
    
    func resetMatchStats() {
        match.reset()
        set.reset()
        game.reset()
        tiebreak.reset()
        
        games = 0
        server = 1
        firstTiebreakServer = 0
    }
    
    func markFourPointsOrAdvantage(player: Int, test: Bool) -> Int {
        switch(player) {
        case 1:
            if (game.player1Score() == "A") {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.green
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                return 1
            } else if (game.player1Score() == "40" && (game.player2Score() != "40" && game.player2Score() != "A")) {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.green
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                
                return 2
            } else if (game.player1Score() == "40" && game.player2Score() == "40") {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                
                return 3
            } else {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                }
                return 4
            }
        case 2:
            if (game.player2Score() == "A") {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                    p2PointsLabel.backgroundColor = UIColor.green
                }
                
                return 5
            } else if (game.player2Score() == "40" && (game.player1Score() != "40" && game.player1Score() != "A")) {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                    p2PointsLabel.backgroundColor = UIColor.green
                }
                
                return 6
            } else if (game.player1Score() == "40" && game.player2Score() == "40") {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                
                return 7
            } else {
                if (!test) {
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                return 8
            }
        default:
            if (!test) {
                p1PointsLabel.backgroundColor = UIColor.white
                p2PointsLabel.backgroundColor = UIColor.white
            }
            break
        }
        return 0
    }
    
    func markAboutToWinTiebreak(player: Int, test: Bool) -> Int {
        switch(player) {
        case 1:
            if (tiebreak.gamePointsForPlayer1() >= 2 && tiebreak.gamePointsForPlayer2() == 0) {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.green
                }
                return 1
            } else {
                if (!test) {
                    p1PointsLabel.backgroundColor = UIColor.white
                }
                return 2
            }
        case 2:
            if (tiebreak.gamePointsForPlayer2() >= 2 && tiebreak.gamePointsForPlayer1() == 0) {
                if (!test) {
                    p2PointsLabel.backgroundColor = UIColor.green
                }
                return 3
            } else {
                if (!test) {
                    p2PointsLabel.backgroundColor = UIColor.white
                }
                return 4
            }
        default:
            break
        }
        
        if (tiebreak.player1Score() == tiebreak.player2Score()) {
            if (!test) {
                p1PointsLabel.backgroundColor = UIColor.white
                p2PointsLabel.backgroundColor = UIColor.white
            }
            return 5
        }
        return 0
    }
    
    func markAboutToWinSet(player: Int, test: Bool) -> Int {
        switch(player) {
        case 1:
            if (set.gamePointsForPlayer1() >= 2 && set.gamePointsForPlayer2() == 0) {
                if (!test) {
                    p1GamesLabel.backgroundColor = UIColor.green
                }
                return 1
            } else {
                if (!test) {
                    p1GamesLabel.backgroundColor = UIColor.white
                }
                return 2
            }
        case 2:
            if (set.gamePointsForPlayer2() >= 2 && set.gamePointsForPlayer1() == 0) {
                if (!test) {
                    p2GamesLabel.backgroundColor = UIColor.green
                }
                return 3
            } else {
                if (!test) {
                    p2GamesLabel.backgroundColor = UIColor.white
                }
                return 4
            }
        default:
            if (!test) {
                p1GamesLabel.backgroundColor = UIColor.white
                p2GamesLabel.backgroundColor = UIColor.white
            }
        }
        
        if (set.player1Score() == set.player2Score()) {
            if (!test) {
                p1GamesLabel.backgroundColor = UIColor.white
                p2GamesLabel.backgroundColor = UIColor.white
            }
            return 5
        }
        return 0
    }
    
    func markAboutToWinMatch(player: Int, test: Bool) -> Int {
        switch(player) {
        case 1:
            switch(match.player1Score()) {
            case "3", "4", "5":
                if (!test) {
                    p1SetsLabel.backgroundColor = UIColor.green
                }
                return 1
            default:
                if (!test) {
                    p1SetsLabel.backgroundColor = UIColor.white
                }
                return 2
            }
        case 2:
            switch(match.player2Score()) {
            case "3", "4", "5":
                if (!test) {
                    p2SetsLabel.backgroundColor = UIColor.green
                }
                return 3
            default:
                if (!test) {
                    p2SetsLabel.backgroundColor = UIColor.white
                }
                return 4
            }
        default:
            break
        }
        return 0
    }
    
    func addPreviousSetPoints(player: Int) {
        p1PreviousSetsLabel.text! += "\(set.player1Score()), "
        p2PreviousSetsLabel.text! += "\(set.player2Score()), "
        
        // Inform user that a set has ended
        // Adapted from Apple Developer (2023A & 2023B)
        let speechUtterance = AVSpeechUtterance(string: "Player \(player) wins the set. Set scores: \(match.player1Score()), \(match.player2Score())")
        speechSynthesiser.speak(speechUtterance)
        // End of adapted code
        
    }
    
    func addPointToPlayer1(test: Bool) {
        if (game.player1Won() || tiebreak.player1Won()) {
            if (!test) {
                secondPoint = switchServer(secondPoint: secondPoint, test: false)
            }
            callNewBallsPlease()
            if (set.player1Won() || tiebreak.player1Won()) {
                match.addPointToPlayer1()
                if (!test) {
                    addPreviousSetPoints(player: 1)
                }
                if (match.player1Won()) {
                    endGame(winner: 1, test: false)
                }
                set.reset()
            } else {
                set.addPointToPlayer1()
            }
            game.reset()
            tiebreak.reset()
        } else {
            if (isTiebreak()) {
                tiebreak.addPointToPlayer1()
                if (!test) {
                    secondPoint = switchServer(secondPoint: secondPoint, test: false)
                }
            } else {
                game.addPointToPlayer1()
            }
        }
        
    }
    
    func addPointToPlayer2(test: Bool) {
        if (game.player2Won() || tiebreak.player2Won()) {
            if (!test) {
                secondPoint = switchServer(secondPoint: secondPoint, test: false)
            }
            callNewBallsPlease()
            if (set.player2Won() || tiebreak.player2Won()) {
                match.addPointToPlayer2()
                if (!test) {
                    addPreviousSetPoints(player: 2)
                }
                if (match.player2Won()) {
                    endGame(winner: 2, test: false)
                }
                set.reset()
            } else {
                set.addPointToPlayer2()
            }
            game.reset()
            tiebreak.reset()
        } else {
            if (isTiebreak()) {
                tiebreak.addPointToPlayer2()
                if (!test) {
                    secondPoint = switchServer(secondPoint: secondPoint, test: false)
                }
            } else {
                game.addPointToPlayer2()
            }
        }
    }
    
    /********Methods*********/
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        addPointToPlayer1(test: false)
        updateLabels()
        markFourPointsOrAdvantage(player: 1, test: false)
        markAboutToWinTiebreak(player: 1, test: false)
        markAboutToWinSet(player: 1, test: false)
        markAboutToWinMatch(player: 1, test: false)
    }
    
    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        addPointToPlayer2(test: false)
        updateLabels()
        markFourPointsOrAdvantage(player: 2, test: false)
        markAboutToWinTiebreak(player: 2, test: false)
        markAboutToWinSet(player: 2, test: false)
        markAboutToWinMatch(player: 2, test: false)
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        // Inform user that the match has restarted
        // Adapted from Apple Developer (2023A & 2023B)
        let speechUtterance = AVSpeechUtterance(string: "Match restarted")
        speechSynthesiser.speak(speechUtterance)
        // End of adapted code
        
        resetMatchStats()
        p1PointsLabel.backgroundColor = UIColor.white
        p2PointsLabel.backgroundColor = UIColor.white
        p1GamesLabel.backgroundColor = UIColor.white
        p2GamesLabel.backgroundColor = UIColor.white
        p1SetsLabel.backgroundColor = UIColor.white
        p2SetsLabel.backgroundColor = UIColor.white
        
        p1PreviousSetsLabel.text = ""
        p2PreviousSetsLabel.text = ""

        p1NameLabel.backgroundColor = UIColor.purple
        p1NameLabel.textColor = UIColor.white
        
        p2NameLabel.backgroundColor = UIColor.white
        p2NameLabel.textColor = UIColor.black
        
        updateLabels()
        
        p1Button.isEnabled = true
        p2Button.isEnabled = true
    }
}

