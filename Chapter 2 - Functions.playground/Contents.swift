func helloWorld(name: String = "World"){
    println("Hello, \(name)")
}

func helloWorld(name:String, numberOfTimes:Int = 1) {
    println("Number of times: \(numberOfTimes)")
    // _ here means that index is not used inside the statement
//    for _ in 1 ... numberOfTimes {
//        helloWorld(name)
//    }
    for i in 1 ... numberOfTimes {
        print("\t(\(i)) ")
        helloWorld(name: name)
    }
}

helloWorld()

helloWorld(name: "Javier")

helloWorld("Javillo in Obje-C",numberOfTimes: 3)

helloWorld("I have a default parameter")

helloWorld(name: "I don't")


// External Names

func hello1(personName: String){
    println("Hello, \(personName)")
}

func hello2(personName: String = "World") {
    println("Hello, \(personName)")
}

func hello3 (toPersonWithNme name: String) {
    println("Hello, \(name)")
}


func hello4(#personName:String){
    println("Hello \(personName)")
}

hello1("Javier")

hello2(personName: "Javillo")

hello3(toPersonWithNme: "Javiersillo")

hello4(personName: "Piedrita 4")