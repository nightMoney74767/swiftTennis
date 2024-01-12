<h1>Swift Tennis</h1>
This repository contains the code for an IOS app with tennis as the theme (created during a software engineering course at University of Chester). The aim was to fully implement back-end code for a pre-existing XCode project. The UI (implemented via the view controller) includes two buttons at the bottom which, when pressed, record a point for the respective player (15, 30 or 40). If the player in question had 40 points or had an advantage point if both players reached 40, said player will win a game. A player will win a set for winning at least 7 games with a 2-game gap between the players. A tiebreak will occur if both players win six or twelve games in the same set. The first to win three sets will win the match.

The number of points, games, sets and tiebreak scores are recorded and updated using four classes (in the TennisStarter folder). All classes use the same functions and variables to maintain consistency. This is further enforced using a protocol (named Scorable), which prevents the code from compiling unless all classes linked to the protocol contain the required functions that the protocol defines. Additionally, the app uses a view controller that allows the scores to be updated on button press. The user can also show the scores on a big screen (Figure 8).

To run this project, you will need to use XCode on a supported macOS device. The IDE can be obtained from the App Store. Double-click the xcodeproj file to open the project in XCode. Unit tests were written to ensure that all functions work as intended in all classes and the view controller. You can find these in the TennisStarterTests folder.