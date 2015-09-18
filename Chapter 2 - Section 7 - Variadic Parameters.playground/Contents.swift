import UIKit

// Variadic, functions can have just one variadic
func sayHello(toPeopleNamed people: String...){
    if people.isEmpty {
        sayHello(toPeopleNamed: "World")
    }
    for person in people {
        println("Hello \(person)!")
    }
}


sayHello(toPeopleNamed: "Javier", "Piedra", "Wagner")
sayHello()
