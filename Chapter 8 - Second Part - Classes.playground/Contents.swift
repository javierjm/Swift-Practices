// Chapter 8 - Optional Params
class BasketBallTeam {
    var name: String
    var affiliation: String {
        willSet(newAffiliation) {
            println("Before: changing affiliation from \(affiliation) to \(newAffiliation)")
        }
        didSet(oldAffiliation){
            println("After: changed affiliation from \(oldAffiliation) to \(affiliation)")
        }
    }
    
     init(name: String, affiliation: String) {
        self.name = name
        self.affiliation = affiliation
    }
    
    convenience init(name: String) {
        self.init(name:name, affiliation:"Intramural Team")
        println("Creating team named \(name)")
    }
    
    func colorCommentary() -> String {
        return "The \(affiliation) \(name)"
    }
}


class ProfessionalBasketballTeam: BasketBallTeam {

    let proLeague : String?

    convenience init() {
        self.init(name: "Globetrotters", affiliation: "Harlem", league: "Independent League")
        self.name = "Wows"
    }
    
    
    init(name: String, affiliation: String, league:String?) {
        self.proLeague = league
        super.init(name: name, affiliation: affiliation)
        
    }
    
    override func colorCommentary() -> String {
        var comment = super.colorCommentary()
        if let var league = proLeague {
                comment += " of the \(proLeague)"
        }
        return comment
    }
    
}

class NBATeam:ProfessionalBasketballTeam {
    // count and maximumNumberOfPlayers added for setion 11 
    
    var count: Int {
        return roster.count
    }
    
    class var maximumNumberOfPlayers: Int {
        return 12
    }
    
    init(name: String, affiliation: String) {
        super.init(name: name, affiliation: affiliation, league:"NBA")
    }
    
    private var roster:[String] = [String](){
        didSet(previousRoster) {
            let count = roster.count
            println("Roster Count: \(roster.count)")
            let previousCount = previousRoster.count
            println("Roster Count: \(previousCount)")
            let existingTeamHasValidRoster = previousCount >= 8 && previousCount <= 12
             println("Valid Rooster ? : \(existingTeamHasValidRoster)")
            if count < 8 && existingTeamHasValidRoster  || previousCount == 0 && count < 8 {
                println("You need \(8 - count) more. Not changing roster.")
                roster = previousRoster
            } else if count > 12 && existingTeamHasValidRoster {
                println("This is \(count - 12) more than allowed. Not changing roster.")
                roster = previousRoster
            }
            println("The roster is \(roster). \n")
        }
    }
    // Addd for section 11 subscript
    subscript(index: Int) -> String {
        //return roster[index]
        // Susbcritps enable to set and get values 
        get {
            assert(index < count, "Index is out of range")
            return roster[index]
        }
        set(newValue) {
            assert(index < count, "Index is out of range")
            roster[index] = newValue
        }
        
    }
}

// Modified Pro Leage var in order to accept nil params
// 1. Added String? to the let type definition
// 2. added String? at init third param to accept nil values
// 3. See the example below
let nilTrotters = ProfessionalBasketballTeam(name: "GlobeNilers", affiliation: "Harlem", league: nil)

// Chapter 9 - Property Observers

// Added for tracking changes to properties variables
//var name: String
//var affiliation: String {
//willSet { println("Before changing affiliation") }
//didSet { println("After changed affiliation") }
//}

let jazz = ProfessionalBasketballTeam(name: "Jazz", affiliation: "New Orleans", league: nil)
jazz.affiliation = "Utah"

// also you can override these observers in subclass, so subclass is called first then super class 


// Chapter 9 Property Validation 

// You can add validators in order to set or not set a property: 


struct Size {
    var width: Double = 10.0 {
        didSet {
            if width < height {
                width = height
            }
        }
    }
    var height: Double = 5.0 {
        didSet {
            if height > width {
                height = width
            }
        }
    }
}

var size = Size()
size.height = 8
size
size.height = 20
size


let jazz2 = NBATeam(name: "Jazz", affiliation: "Utah")
jazz2.roster += ["Favors", "Kanter", "Burks", "Burke","Favors", "Kanter", "Burks", "Burke"]

// Section 11 - Using Subscripts 



//When we write real apps, we create projects and have our classes, structs, and enumerations in different files. In larger projects we organize these files into different logical groupings called modules.
//Swift provides thee access control levels that allow us to indicate who can see our properties and methods.

//Use private to indicate that a member is only visible within the same source file.

//Use internal to allow members to be used from any file within the same module. This is the standard default access level.

//Use public to allow members to be used within the same module, within any file that imports that module, and within any file that is part of another module that imports that module.


// private var roster:[String] = [String](){  // ...

// The subscript() method allows us to access the elements of roster using array access notation, like this.

jazz2[0]

// We use the class keyword for a class property or method. You might remember we used the static keyword for a type property or method in an enumeration. We use static in the case of a struct, as well.

func teamRoster(team: NBATeam) {
    println("The roster for the \(team.name) is")
    for i in 0 ..< min(team.count, NBATeam.maximumNumberOfPlayers) {
        println("\t \(team[i])")
    }
}

teamRoster(jazz2)

//What happens if other people using our API are not so careful? What if they try to access of change the roster using an index that is too high or too low?
//We can add an assertion to our getter and another to our setter to assert that the index is never greater than the number of elements in the roster array.
// See:      assert(index < count, "Index is out of range")

let cavs = NBATeam(name: "Cavaliers", affiliation: "Cleveland")
//cavs[0]

// Section 12 - Loading and Uloading

// Swift supports lazy loading : 

class Announcer {
    var name: String
    // assuming creating a Team is a expensive operation, we will add lazy keyword, so
    lazy var team = BasketBallTeam(name: "Old and Tired", affiliation:"")

    init(name: String){
        self.name = name
    }
    
    deinit {
        // Clean Up resources
    }
}


let announcer = Announcer(name: "Booming Voice")
println("Created \(announcer.name)")
announcer.team.colorCommentary()


// We clear out resources when an Announcer instance is about to go away with a deinit clause. Use deinit to delete the Announcer's team, or break a database connection, or clear a large cache.

// Section 13 - Structs vs Classes 

//“Here are some cases in which you will prefer classes to structs.
//If instances need to be shared by different entities in your application.
//If you need to pass by reference and not by value.
//If you need to inherit and share behavior among a hierarchy of types.
//If you need to inherit from Cocoa or Cocoa Touch to create view or controller instances.