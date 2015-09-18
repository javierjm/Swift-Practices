import UIKit


// Section 1 - creating a class
class BasketBallT {

}

//“BasketballTeam isn't a subclass of NSObject. It isn't a subclass of anything. This is called a Base Class in Swift
// So an instance is: 

var bt = BasketBallT()

// Section 2 - Properties

class BasketBallTP {
//    let name, affiliation: String // Error here, properties must be initialized, like this: 
    var name, affiliation: String
    
    // Added for Section 6  we can insist that all subclasses of BasketballTeam implement an initializer, by adding the required keyword to the initializer in BasketballTeam. Add required to both initializers in BasketballTeam.
   required init(name: String, affiliation: String) {
        self.name = name
        self.affiliation = affiliation
    }
    // Added for Section 6
    required convenience init(name:String) {
        self.init(name:name, affiliation:"Intramural Team")
    }
    
    func colorCommentary() -> String {
        return "The \(affiliation) \(name)"
    }
}

var btp = BasketBallTP(name: "Jazz", affiliation: "Utah")
btp.colorCommentary()

// Notice rules for init method are different, here we use all the parameters name, instead other methods where we drop the first param 
// “An initializer that initializes all of the properties in that class is known as a designated initializer.

// Section 3 - Subclasses 

class ProfessionalBasketballTeam: BasketBallTP {
//  The rule is that if we introduce a new property in a subclass, then that property must be initialized before we call up to the superclass' init() method.
    let proLeague : String
    // Added for section 6
    convenience init() {
        self.init(name: "Globetrotters", affiliation: "Harlem", league: "Independent League")
    }
    
    init(name: String, affiliation: String, league:String) {
        self.proLeague = league
        super.init(name: name, affiliation: affiliation)
    }
    
    
    required init(name: String, affiliation: String) {
        proLeague = "Neighborhood League"
        super.init(name: name, affiliation: affiliation)
    }
    
    required convenience init(name: String) {
        self.init(name: name, affiliation: "Intramural Team", league: "Neighborhood League")
    }
    
    override func colorCommentary() -> String {
        return super.colorCommentary() + " of the \(proLeague)"
    }

}

class CollegeBasketballTeam: BasketBallTP {
    let conference: String
    init(name: String, affiliation: String, conference:String) {
        self.conference = conference
        super.init(name: name, affiliation: affiliation)
    }
    
    required init(name: String, affiliation: String) {
        conference = "Neighborhood Conference"
        super.init(name: name, affiliation: affiliation)
    }
    
    required convenience init(name: String) {
        self.init(name: name, affiliation: "Intramural Team", conference: "Neighborhood Conference")
    }

//    override final func colorCommentary() -> String {
//        return super.colorCommentary() + " of the \(conference)"
//    }
//
    
}

// Notice the colon for designating a super class, is the same as protocols, so we can do this: 
// class MyClass: SuperClass, ProtocolOne, ProtocolTwo, ProtocolThree

let jazz = ProfessionalBasketballTeam(name: "Jazz", affiliation: "Utah", league:"NBA")
jazz.colorCommentary()
let buckeyes = CollegeBasketballTeam(name: "Buckeyes", affiliation: "Ohio State", conference: "West")
buckeyes.colorCommentary()

// Section 4 - Overriding methods

// see override func colorCommentary() swift automatcally adds override keyword (safety)
// When you create a method, you can declare it as final to prevent subclasses from overriding it. To see this, add the word final before the definition of the colorCommentary() method in BasketballTeam.

// Section 5 - Passig by Reference 

// Contrary o enums and structs that are passed by value 

jazz.colorCommentary()
jazz.affiliation = "New Orleans" // Error
jazz.colorCommentary()

//This behavior differs from structs.
//With structs, if we want to change the value of a property, the variable representing the struct and the property both have to be variable. If either is constant, we can't change the value of the property.
//With classes, if we want to change the value of a property, the property must be variable but the class instance can be a constant or a variable.”

let secondJazz = jazz
secondJazz.affiliation = "Colorado"
jazz.colorCommentary()
secondJazz.colorCommentary()

/**
    Notice how the affiliation value of "jazz" is changed when we change to "secondJazz" since both constats are pointing the same object
*/

// If we combine classes and structs this happens: (Array is a kind of struct) 

let originalJazz = ProfessionalBasketballTeam(name: "Jazz", affiliation: "New Orleans", league: "NBA")
let cavs = ProfessionalBasketballTeam(name: "Cavaliers", affiliation: "Cleveland",    league: "NBA")

let teams = [originalJazz, cavs]

teams[0].colorCommentary()
teams[0].affiliation = "Utah"
teams[0].colorCommentary()

/**
The teams array is a constant struct. We can't change the teams array or any of its contents.
This is a somewhat confusing and subtle issue. The fact is, the jazz constant itself is not being changed at all. It still points to the same memory location. The contents of that memory location has been changed.”
*/

// Section 6 - Convenience Initializers 

// “If you call a convenience initializer, the chain of calls must eventually end up calling a designated initializer in the same class.”
// “A convenience initializer can't call a designated initializer in a superclass.
// “No initializer can call a convenience initializer in a superclass.

// We aren't required to implement required convenience initializers in subclasses if the ones we inherit do everything we need. In this case, they don't. See 2 required inits in BasketballT and notice how ProfessionalBasketaballTeam only implements the designated