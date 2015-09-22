let numberOfHoursInStandardWeek = 40

class Employee : Payable {
    var hourlyWage: Int
    init(hourlyWage: Int) {
        self.hourlyWage = hourlyWage
    }
    
    func weeklyPay() -> Int {
        return 0
    }
}

class SalariedEmployee : Employee {
    
    override func weeklyPay() -> Int {
        return numberOfHoursInStandardWeek * hourlyWage
    }
}

class HourlyEmployee : Employee {
    var numberOfHours = 0
    
    override func weeklyPay() -> Int {
        switch numberOfHours {
        case 0 ... numberOfHoursInStandardWeek where hourlyWage < 50:
            return numberOfHours * hourlyWage + 30
        case numberOfHoursInStandardWeek ... (24 * 7):
            let overtimeHours = numberOfHours - numberOfHoursInStandardWeek
            return (numberOfHours + overtimeHours) * hourlyWage
        default:
            return numberOfHours * hourlyWage
            
        }
    }
}

func calculatePay (payee: Payable) -> Int {
    return payee.weeklyPay()
}


// Section 7 - Protocol


// Let's modify payEmployee to accept an element that implements this protocol:
protocol Payable {
    func weeklyPay() -> Int
}


let partTimeEngineer = HourlyEmployee(hourlyWage: 60)
partTimeEngineer.numberOfHours = 30
calculatePay(partTimeEngineer)                                                     // 1,800
let underpaidPartTimeEngineer = HourlyEmployee(hourlyWage: 40)
underpaidPartTimeEngineer.numberOfHours = 30
calculatePay(underpaidPartTimeEngineer)


// Section 8 - Polymorphism through Protocol 

// Since we have a protocol we an have structs and enums that conform the protocol: 

struct SalesPerson: Payable {
    var weeklySales:Int
    
    func weeklyPay() -> Int {
        return weeklySales / 8
    }
}


let salesPerson = SalesPerson(weeklySales: 20000)
calculatePay(salesPerson)

// Let's create Expenses enum

enum Expenses:Payable {
    case Rent(Int)
    case Supplies(Double, Int)
    
    func weeklyPay() -> Int {
        switch self {
        case .Rent(let rentPerWeek):
            return rentPerWeek
        case .Supplies(let rate, let units):
        return Int(rate * Double(units))
    }
    }
}


let suburbanOffice = Expenses.Rent(7500)
calculatePay(suburbanOffice)                                                      // 7,500

let printerPaper = Expenses.Supplies(4.99, 18)
calculatePay(printerPaper)

// Section 9 - Optional Chaining 

// What happen if we work with several optionals 

struct Publisher {
    // Added for Section 10
    typealias USDollars = Int
    var authors = [String:Author] ()
}

struct Author {
    var titles = [Title] ()
}

struct Title {
    let numberSold:Int
    
    func royalties()->Int {
        return Int(0.15 * Double(numberSold))
    }
}


// First Optional: Dictionary Authors may not have any author 
// Second Optional: an Author in Dictionary may not have any title published 

extension Publisher {
    func royaltiesOnFirstBookForAuthorWithNameUgly(authorName: String) -> Int? {
        if let validAuthor = authors[authorName] {
            if let validFirst = validAuthor.titles.first {
                return validFirst.royalties()
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    // for Section 10: replaced Int by USDollars

    // Previous func could be written like this:
    // Following /** */ is added as part of method description
    /** USDollars is an Int*/
    func royaltiesOnFirstBookForAuthorWithNameNice(authorName: String) -> USDollars? {
        return authors[authorName]?.titles.first?.royalties()
        // The continuation of the expression after the ? that follows authors[authorName] and first is what we mean by optional chaining. The value of the expression is nil unless all of the optionals in the chain can be unwrapped. The evaluation of the expression stops at the first optional that evaluates to nil.
    }
}

// Let's create a publisher with two authors, one with books and other without
let murderByOptionals = Title(numberSold: 400)
let oneHitWonder = Author(titles: [murderByOptionals])

let aspiringWriter = Author()
let publisher = Publisher(authors: ["Determined": aspiringWriter, "Fluff": oneHitWonder])



// Check royalties for 3 authors 
// 1 without book 
// 1 with 1 book 
// 1 that doesn't exits 

publisher.royaltiesOnFirstBookForAuthorWithNameNice("Determined")
publisher.royaltiesOnFirstBookForAuthorWithNameNice("Fluff")
publisher.royaltiesOnFirstBookForAuthorWithNameNice("Javier not here")

// notice we coudl wrap the royaltiesOnFirstBookForAuthorWithNameNice function for returning a defualt int value for nil like this: 
//         return (authors[authorName]?.titles.first?.royalties() ?? 0 )

// MARK: SECTION 10
// Section 10 - Meaningful Names 

let royaltiesOnFluff = publisher.royaltiesOnFirstBookForAuthorWithNameNice("Fluff")


// we can use type Aliaas to create a more descriptive type named USDollar that still is an Int
// for example control + click on royaltiesOnFluff and will see a value USDollars for it

//Another way to document code is by adding Mark: Something -> assuming this is replacement for Pragma Mark 

//For example, suppose you want to remember to come back later and add the USDollars type alias to Title. Create a TODO: comment. You can identify code that needs fixing using a FIXME: comment.
//Note that MARK:, TODO:, and FIXME: all include the trailing colon, :.
//Here's how you would use the TODO: and FIXME: styles of comment

// TODO: Find the fucking jump bar to see the pragma 
// FIXME: find somehting wrong and fix it 


// Section 11 - Type Alias 



protocol Player {
    var name: String { get }
}
struct BasketballPlayer: Player {
    let name: String
}
struct HockeyPlayer: Player {
    let name: String
}

let tonyParker = BasketballPlayer(name: "Tony Parker")
let lebronJames = BasketballPlayer(name: "Lebron James")
let sidneyCrosbey = HockeyPlayer(name: "Sidney Crosbey")


class Team {
    var players = [Player]()
    func list() -> String {
        return players.map{$0.name}.reduce("Roster:"){$0 + "\n" + $1}
    }
}


protocol Groupable {
    typealias TeamPlayer
    func add(player: TeamPlayer)
}


// We use typealias to say that in the case of BasketballTeam, the TeamPlayer placeholder in Groupable is replaced by BasketballPlayer.

class BasketballTeam: Team, Groupable {
    typealias TeamPlayer = BasketballPlayer

    func add(player: TeamPlayer) {
        players.append(player)
    }
}

class HockeyTeam: Team, Groupable {
    typealias TeamPlayer = HockeyPlayer
    func add(player: TeamPlayer) {
        players.append(player)
    }
}

let cavs = BasketballTeam()
cavs.add(lebronJames)
cavs.add(tonyParker)
cavs.list()

