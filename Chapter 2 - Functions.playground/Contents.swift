// Section 2 - Single Parameter: 
// The order is always : nameOfVariable:TypeOfVariable

// added = "World" to the name parameter in order to set Default value
func helloWorld(name: String = "World"){
    println("Hello, \(name)")
}

// Section 3 - Overloading

// Swift accept create same function name with different parameters 

// Section 4 - Muliple parameters:

func helloWorld(name:String, numberOfTimes:Int = 1) {
    println("Number of times: \(numberOfTimes)")
    // _ here means that index is not used inside the statement
//    for _ in 1 ... numberOfTimes {
//        helloWorld(name)
//    }
    for i in 1 ... numberOfTimes {
        // In this case \t provides a Tabular print
        print("\t(\(i)) ")
        helloWorld(name: name)
    }
}

helloWorld()
helloWorld(name: "Javier")
helloWorld("Javillo in Obje-C",numberOfTimes: 3)

// Section 5 - Default Values 

// see the folowing call, it attempts to call the helloWorld(name:String, numberOfTimes:Int = 1) so it defaults to 1 since no Int was added.
helloWorld("I have a default parameter")
// The following function will call straigth the func helloWorld(name: String = "World") function
helloWorld(name: "I don't")


// External Names

// the following funtion does not have external name and neither default value
func hello1(personName: String){
    println("Hello, \(personName)")
}

// “When a parameter has a default value, we are required to use the parameter name to call it.”
// “When a parameter has a default value, it's given an external name that is the same as its local name”
func hello2(personName: String = "World") {
    println("Hello, \(personName)")
}
// Then we can name our external parameter as here:
func hello3 (toPersonWithNme name: String) {
    println("Hello, \(name)")
}

// we can use the # for naming the external parameter equals to the internal one
func hello4(#personName:String){
    println("Hello \(personName)")
}

hello1("Javier")
hello2(personName: "Javillo")

hello3(toPersonWithNme: "Javiersillo")

hello4(personName: "Piedrita 4")


// Section 7 - Variadic Parameters 

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


// Section 8 - Return Values

func helloWorldReturn(name: String = "World") -> String {
    return "Hello, \(name)!"
}

// "-> String" is the way we define we are returning a String 


// Section 9 - Returning Tuples 

// The following func return multiple values
func sayHi(toTheFollowingPeople people: String...) -> (Int, String) {
    return (people.count, people.reduce("Hello"){$0 + ",\n " + $1})
}

// When we call the function we use the .0 and 0.1 to access the returning values, also we can name the tuple values and use them to access the individual elements of the tuple: 

func sayHiTo(theFollowingPeople people: String...) -> (count: Int, peopleList: String) {
    return (people.count, people.reduce("Hello"){$0 + ",\n " + $1})
}

let count = sayHiTo(theFollowingPeople: "Javier", "Laura", "Chisco").count
let names = sayHiTo(theFollowingPeople: "Javier", "Laura", "Chisco").peopleList




