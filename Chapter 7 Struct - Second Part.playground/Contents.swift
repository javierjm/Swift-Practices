import UIKit

// Section 7 - Computed Properties 
prefix operator √ {}

prefix func √ (argument: Double) -> Double {
    return sqrt(argument)
}

struct Vertex {
    var x, y : Double
    func coordinates() -> (Double, Double) {
        return (x, y)
    }
    
    func distanceFrom(other otherPoint: Vertex) -> Double {
        let deltaX = otherPoint.x - self.x
        let deltaY = otherPoint.y - self.y
        let distance = √(deltaX * deltaX + deltaY * deltaY)
        return distance
    }
    
    var distanceFromOrigin: Double {
//        get {
            let origin = Vertex(x: 0, y: 0)
            return distanceFrom(other: origin)
//        }
    }
}

// Several things from here :
// 1. distanceFromOrigin is the name of new property, type Double. 
// 2. Since we are not using setter, we can ommit the get keyword
var pointOne = Vertex(x: 3.0, y: 4.0)
pointOne.distanceFromOrigin


// Section 8 - Mutating Methods

extension Vertex {

    mutating func scaleBy(multiplier:Double) {
        x *= multiplier
        y *= multiplier
    }
    
    mutating func moveBy(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}
// Section 9 - Mutating Functions
// Here's what Swift does for method parameter names. By default, the first parameter name is dropped. The remaining parameter names, again by default, are both local and external names.

pointOne.scaleBy(3)
pointOne.moveBy(2, y: 4)

// If a method has more than one parameter, we include a reference to the first parameter's name in the name of the method, like this.
// mutating func moveByX(x:Double, y:Double) 
// So is clearer to read, we do not force to use the first parameter with "#"

//the Formal name of moveByX() including its parameter names is moveByX(_:, y:). ”

// However is not mandatory, there is not an standard and moveByX sounds like method is just for X

// Section 10 Composition 
// We can use inheritance for structs, however we can create Structs from other structs 

struct VertexC {
    var x,y: Double
    mutating func moveBy(#x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}
//  “Size might have a scaleBy() function that allows us to scale in either direction

struct Size {
    var width,height: Double
    mutating func scaleBy(#width: Double, height: Double) {
        self.width *= width
        self.height *= height
    }
}


struct Rectangle {
    var topLeftCorner:VertexC
    var dimensions:Size
    var area:Double {
        return dimensions.height * dimensions.width
    }
    var perimeter:Double {
        return 2 * (dimensions.height + dimensions.width)
    }
    mutating func moveBy(#x: Double, y: Double) {
        topLeftCorner.moveBy(x: x, y: y)
    }
    mutating func scaleBy(#width: Double, height: Double) {
        dimensions.scaleBy(width: width, height: height)
    }
}

var rect = Rectangle(topLeftCorner: VertexC(x: 0.0, y: 0.0), dimensions: Size(width: 2.0, height: 2.0))

rect.perimeter

rect.moveBy(x: 2.0, y: 2.0)
rect.scaleBy(width: 2.0, height: 2.0)
rect
rect.area


// Section 11 - When use Enums, or when use Structs 

// Enums : when need a fixed size of options, if you have to add "complex" associated data, will be better a struct 

enum BasketballPosition: Int {
    case PointGuard, ShootingGuard, SmallForward, PowerForward, Center
}

struct BasketballPlayerE {
    let name: String
    let number: Int
    let position: BasketballPosition
}


let tonyParker = BasketballPlayerE(name: "Tony Parker", number: 9, position: BasketballPosition.PointGuard)
tonyParker.name                                                           // "Tony Parker"
tonyParker.number                                                         //             9
tonyParker.position

//much clearer


// Section 12 - Struct Protocols

// Most of clases use in Obj-C can now be used as Structs, only if we do not inheritance 

protocol Playable {
    var name: String { get }
}

struct BasketballPlayer:Playable {
    let name: String
}

struct HockeyPlayer:Playable {
    let name: String
}

func announceNameFor(player: Playable) {
    println("Fuck yeah is \(player.name)")
}

let javiBasket = BasketballPlayer(name: "Javier Basket")
let javiHockey = HockeyPlayer(name: "Javier Hockey")

announceNameFor(javiBasket)


func canPlayOneOnOne(playerOne: Playable, playerTwo: Playable) -> Bool {
    return playerOne.name != playerTwo.name
}

canPlayOneOnOne(javiBasket, javiBasket)
canPlayOneOnOne(javiBasket, javiHockey)

// see the code above ! -> in this case the function allows me to play basketball and hockey players together :(, this shouldn't be possible. 
// we can add safety type by forcing function to accept generics of one type only: 

func canPlayOneOnOneG <T: Playable>(playerOne: T, playerTwo: T) -> Bool {
    return playerOne.name != playerTwo.name
}

canPlayOneOnOneG(javiBasket, javiBasket)
//canPlayOneOnOneG(javiBasket, javiHockey) //->this throws an error

let lauBasket = BasketballPlayer(name: "Lau Basket")
canPlayOneOnOneG(javiBasket, lauBasket)