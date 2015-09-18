// Section 2 - Switch Enum

import UIKit

enum BasketballPosition: Int {
    case PointGuard, ShootingGuard
    case SmallForward, PowerForward
    case Center
}
var colorCommentary = "a"

var ballHandler = BasketballPosition.PowerForward

switch ballHandler {
    // Whe can evaluate more than one position in a case statemen
    case .PointGuard, .ShootingGuard:
    colorCommentary = "One of the Guards has the ball"
case .PowerForward:
    colorCommentary = "The Power Forward has the ball"
default:
    colorCommentary = "The ball needs to go to Power Forward"
}

colorCommentary

// “We don't need curly braces around the body of what is executed for each case.
// We don't need end statement for switch

// Section 3 - Underlying Int Values

// just add :Int after declaration name
//“By default, enumerations of type Int like BasketballPosition are 0 based. Swift refers to this underlying value as the raw value. The raw value of PointGuard is 0,  ShootingGuard is 1, and so on.
// By asking rawValue, returns de designated value in the Enum
ballHandler.rawValue
// Also we can assing a numnber for the first case 


// Section 4 - Optional Values


//Swift takes the safe route here. Whenever you try to create an enumeration instance from a raw value, Swift returns an optional. Swift is telling you that either you got a valid value or you got nil.

//var pos = BasketballPosition(rawValue:2)
//pos!.rawValue


var potentialBallHandler:BasketballPosition?

potentialBallHandler = BasketballPosition(rawValue: 3)
if let ballHandler = potentialBallHandler {
    let positionNumber = ballHandler.rawValue                                         // 3
}

//Section - 5 Sring Raw Values


enum BasketballPositionS: String {
    case PointGuard = "point guard", ShootingGuard = "shooting guard"
    case SmallForward = "small forward", PowerForward = "power forward"
    case Center = "center"
}

let ballHandlerS = BasketballPositionS.ShootingGuard
let ballHandlerDescriptionS = ballHandlerS.rawValue


// For Strings there is no way to default value and increment on each case cluse, we must set values for each

// Section 6 - Dictionary Keys

var spursPlayers : [BasketballPositionS :String]

spursPlayers = [.PointGuard: "Tony Parker",
.ShootingGuard: "Danny Green",
.SmallForward: "Kawhi Leonard",
.PowerForward: "Tim Duncan",
.Center: "Tiago Splitter"]

spursPlayers[.ShootingGuard]

func checkTheFloor()->Bool {
    return spursPlayers.count == 5
}

checkTheFloor()

for (position, playerName) in spursPlayers {
    println("The \(position.rawValue) is \(playerName)")
}

// “As I said before, the big deal is that the compiler is checking for us. We saw that if the keys are Strings, then it is easy to mistype the key and add an entry to the dictionary when we mean to replace one. Using an enumeration keeps us from making the same mistake.

// Section 7 - Associated Values 

// We can associated different raw values depending on our needs.
enum BasketballPositionAV {
    case PointGuard, ShootingGuard (Int, String)
    case SmallForward, PowerForward(Int, String)
    case Center
}

let tonyParker = BasketballPositionAV.PointGuard
let timDuncan = BasketballPositionAV.PowerForward(21, "Tim Duncan")
let kyleAnderson = BasketballPositionAV.PowerForward(5, "Kyle Anderson")
let javierJara = BasketballPositionAV.ShootingGuard(5, "Javillo")
let ballHandlerAV = javierJara//timDuncan
// “Also, currently the only way to access an associated value is with a switch statement.


switch ballHandlerAV {
case BasketballPositionAV.PowerForward(let uniformNumber, let playerName):
    colorCommentary = "The ball handler is number \(uniformNumber), power forward \(playerName)."
case BasketballPositionAV.ShootingGuard(let uniformNumber, let playerName):
    colorCommentary = "The ball handler is the ShootingGuard \(playerName)"
default:
    colorCommentary = "I can't see who has the ball."
}
colorCommentary               // The ball handler is number 21, power forward Tim Duncan."

// Section 8 Computed Properties 


enum BasketballPositionCP {
    case PointGuard(Int, String), ShootingGuard(Int, String)
    case SmallForward(Int, String), PowerForward(Int, String)
    case Center(Int, String)
    
    var uniformNumber: Int {
        switch self {
        case .PointGuard(let uniformNumber, _):
            return uniformNumber
        case .ShootingGuard(let uniformNumber, _):
            return uniformNumber
        case .SmallForward(let uniformNumber, _):
            return uniformNumber
        case .PowerForward(let uniformNumber, _):
            return uniformNumber
        case .Center(let uniformNumber, _):
            //    default:
            //        return -1
            return uniformNumber
        }  // note we no longer need or want the default case
    }
    
    var playerName: String {
        switch self {
        case .PointGuard(_, let playerName):
            return playerName
        case .ShootingGuard(_, let playerName):
            return playerName
        case .SmallForward(_, let playerName):
            return playerName
        case .PowerForward(_, let playerName):
            return playerName
        case .Center(_, let playerName):
            return playerName
        }
    }
    
    func playerDescription() -> String {
        return "The ball handler is number \(self.uniformNumber), \(self.playerName)."
    }
    
    static func count() -> Int {
        return 5
    }
    
    static func enumDescription()-> String {
        return "A simple Enum that list Basketball positions"
    }
}

// This is the getter for uniformNumber so we don't need to extract the String associated value that represents the player name. That's why we use the _ for the second parameter name. It's a way of telling Swift that there are two parameters but we don't care about the second one. Same for playerName 

var ballHandlerCP = BasketballPositionCP.ShootingGuard(21, "Javillo")
let colorCommentaryCP = "The ball is in possition of \(ballHandlerCP.uniformNumber) -  \(ballHandlerCP.playerName) "

let desc = ballHandlerCP.playerDescription()

// Section 10 Methods
// Enumerations can contain functions in swift, when an enum has a funcion we call it methods 
// See func playerDescription in BasketBallPositionCP

//We can also create type methods for enumerations.
//    These are methods that we call on BasketballPosition and not on an instance of BasketballPosition. We use the static keyword to add a simple count() method to BasketballPosition, like above (see func count()).

let enumDesc = BasketballPositionCP.enumDescription()
let enumCount = BasketballPositionCP.count()


func commentary2 (position:BasketballPositionCP) -> String {
    return position.playerDescription()
}

let colorCommentary2 = commentary2(ballHandlerCP)

// Section 11 Subscripts 


enum BasketballPositionSub: Int {
    case PointGuard, ShootingGuard, SmallForward, PowerForward, Center
    static func count() -> Int {
        return 5
    }
    
    subscript(index: Int) -> BasketballPosition? {
        return BasketballPosition(rawValue: index)
    }
}

let spursPlayersSub = [BasketballPositionSub.PointGuard: "Tony Parker",
    .ShootingGuard: "Danny Green",
    .SmallForward: "Kawhi Leonard",
    .PowerForward: "Tim Duncan",
    .Center: "Tiago Splitter"]


// Try to call the subscript on BasketballPosition, as shown below, and you'll get the error Expected member name or constructor call after type name. The issue is that we can only use subscripts on instances of an enumeration.

let basketballPosition = BasketballPositionSub.PointGuard

    for i in 0 ..< BasketballPositionSub.count() {
        if let positionSub = basketballPosition[i] {
            let temp = positionSub.rawValue
//            let tempName = spursPlayersSub[positionSub]!
            temp
//            println("Playing the \(positionSub.rawValue), it's \(spursPlayersSub[positionSub]!).")
        } else {
            println("No one is playing the \(i + 1).")
        }
    }

//Section 12 Protocols 
// From Section 11 Protocols
protocol PlayerDescribable {
    func playerDescription() -> String
}

protocol PlayerAgeDescibable {
    func playerAgeDescription() -> String
}

enum BasketballPositionP : PlayerDescribable {
    case PointGuard(Int, String), ShootingGuard(Int, String)
    case SmallForward(Int, String), PowerForward(Int, String)
    case Center(Int, String)
    
    var uniformNumber: Int {
        switch self {
        case .PointGuard(let uniformNumber, _):
            return uniformNumber
        case .ShootingGuard(let uniformNumber, _):
            return uniformNumber
        case .SmallForward(let uniformNumber, _):
            return uniformNumber
        case .PowerForward(let uniformNumber, _):
            return uniformNumber
        case .Center(let uniformNumber, _):
            //    default:
            //        return -1
            return uniformNumber
        }  // note we no longer need or want the default case
    }
    
    var playerName: String {
        switch self {
        case .PointGuard(_, let playerName):
            return playerName
        case .ShootingGuard(_, let playerName):
            return playerName
        case .SmallForward(_, let playerName):
            return playerName
        case .PowerForward(_, let playerName):
            return playerName
        case .Center(_, let playerName):
            return playerName
        }
    }
    
    func playerDescription() -> String {
        return "The ball handler is number \(self.uniformNumber), \(self.playerName)."
    }
    
    static func count() -> Int {
        return 5
    }
    
    static func enumDescription()-> String {
        return "A simple Enum that list Basketball positions"
    }
}

var ballHandlerP = BasketballPositionP.ShootingGuard(21, "Javillo")
ballHandlerP.playerName

func commentaryP (position:PlayerDescribable) -> String {
    return position.playerDescription()
}

let comm = commentaryP(ballHandlerP)


// Second Approach of protocols: Create an Extension and declare de playerDescription in Extension instead inside Enum, also enum will not extend the protocol anymore, this is going to be responsability of Extension: 

extension BasketballPositionP : PlayerAgeDescibable {
    func playerAgeDescription() -> String {
        return "The Player is just: \(self.uniformNumber) years old"
    }
}

func commentaryPA(position:PlayerAgeDescibable) -> String {
    return position.playerAgeDescription()
}

var ballHandlerPA = BasketballPositionP.ShootingGuard(21, "Javillo")


commentaryPA(ballHandlerPA)


// Section 12 Passing By Value

enum BasketballPositionPV : String {
    case PointGuard = "Point Guard", ShootingGuard = "Shooting Guard"
    case SmallForward = "Small Forward", PowerForward = "Power Forward"
    case Center = "Center"
}


var playerOne = BasketballPositionPV.PointGuard
var playerTwo = playerOne

playerOne.rawValue
playerTwo.rawValue

playerOne = .ShootingGuard

playerOne.rawValue
playerTwo.rawValue

playerTwo = .Center


playerOne.rawValue
playerTwo.rawValue

// Even if at the initial, the playerOne and playerTwo had the same values, they are separte objects, so manipulating won't affect the other object
