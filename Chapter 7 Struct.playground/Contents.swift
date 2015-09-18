import Foundation

prefix operator √ {}

prefix func √ (argument: Double) -> Double {
    return sqrt(argument)
}


// Section 1 - Create Struct 

struct Vertex1 {

}

// Structs cand inherit from other types 
// A Struct meant to encapsulate data 

let point1 = Vertex1()
point1


// Section 2 - Stored Properties 
// Stored properties don't have getters or setters


struct Vertex2 {
    // This is one option for creating properties with initial values
    let xW = 3.0
    let yH = 4.0
    // this is another option using init method
    let x,y : Double
    init() {
        x = 3.0
        y = 4.0
    }
    // Even when properties has been declared constatns, we can set it's value on initialization via params.
    init(x: Double, y:Double) {
        self.x = x
        self.y = y
    }
    
}

let point2 = Vertex2()
point2
point2.x
point2.y

// Notice: we MUST use the local name as external parameter, otherwise will get an error
let newPoint = Vertex2(x: 5.0, y: 6.0)
newPoint

// We can explicit external name by using _ so, here is a newer implementation of Vertex


struct Vertex3 {
    let x,y : Double

    init(_ x: Double, _ y:Double) {
        self.x = x
        self.y = y
    }
}

let point3 = Vertex3(6.0, 6.0)


// “There's one more important thing to know about stored properties in structs. Structs automatically get memberwise initializers. This means that we can create our Vertex struct like this.

struct VertexDefault {
    let x, y : Double
}

let pointDef = VertexDefault(x: 5.0, y: 6.0) // local parameter name MUST be added when using default's swift implementation
pointDef

// Section 3 - Constant Structs

struct VertexCS {
    let x, y : Double
}

let pointC = VertexCS(x:5.0, y:6.0)
pointC.x
pointC.y

// we cannot assign values to the properties since they are Constants (let) 

// in order to change values, we MUST set properties to keyword "var" and also the pointC mus be Variable.
// “If a struct is constant then all of its properties are automatically constants even if they are marked as variable using the keyword var”

// Here is a difference with classes, if a class is Constant but it's properties are variables, we can change the properties 

// Section 4 - Passing by Value: 

// So we could do this:
//var pointOne = Vertex(x: 3.0, y: 4.0)                                    // {x 3.0, y 4.0}
//var pointTwo = pointOne
// both var are diferent objects and it's manipulation will not affect the other. 
// Vs classes that are passed by reference -> here manipulation will affect the other 

// Section 5 - Methods

struct Vertex {
    let x, y : Double
    func coordinates() -> (Double, Double) {
        // here we can ommit self in return (self.x, self.y) since there is no ambiguity collitions
        return (x, y)
    }
    
    func distanceFrom(other otherPoint: Vertex) -> Double {
        let deltaX = otherPoint.x - self.x
        let deltaY = otherPoint.y - self.y
        let distance = √(deltaX * deltaX + deltaY * deltaY)
        return distance
    }
}
let pointOne = Vertex(x: 5.0, y: 6.0)
pointOne
let (pointx, pointy) = pointOne.coordinates()
pointx

let pointTwo = Vertex(x: -2.0, y: 16.0)

var distance = pointOne.distanceFrom(other: pointTwo)


// Section 6 - Custom Operators 

// We can create prefix, infix and suffix ops
// Notice that I've added these lines at the top: 

//prefix operator √ {}
// 
//prefix func √ (argument: Double) -> Double {
//    return sqrt(argument)
//}

// so now I could use the operator like this:
// let distance = √(deltaX * deltaX + deltaY * deltaY) // instead sqrt function
let test = √(4.0)
test


//Define the operator as a custom infix operator for Doubles by adding this to our playground just below the definition of √. Note that this time we don't include the keyword infix before our function definition.
//infix operator ^-^ {}
//
//func ^-^ (number: Double, power: Double) -> Double {
//    return pow(number, power)
//}

//Here's how we use ^-^ in our distance calculation.
//let distance = √( deltaX^-^2 + deltaY^-^2)  // there's an error

//The error says Non-associative operator is adjacent to operator of same precedence.
//The problem is that Swift doesn't know whether to square deltaX and deltaY and then add them together or whether to apply the addition first.
//This is actually a situation you're familiar with. Consider 2 + 3 * 5. Because multiplication has higher precedence than addition we multiply the 3 and 5 first and then add 2 to the product.
//The Swift Language Reference tells us that the precedence for addition level operators is 140, for multiplication level operators is 150, and for exponential level operators is 160. We need to give ^-^ the precedence of 160.
infix operator ^-^ {precedence 160}

func ^-^ (number:Double, power: Double) -> Double {
    return pow(number, power)
}
// The error disappears and the distance from pointOne to pointTwo is correctly calculated as 13.0.

// to define a posfix: 

let distanceInfix = √( 3^-^2 + 3^-^2)
distanceInfix

postfix operator ^^ {}

postfix func ^^ (number:Double) -> Double {
    return number * number
}

//“We'd use ^^, like this.
let distance1 = √( 3^^ + 3^^ )
distance1
