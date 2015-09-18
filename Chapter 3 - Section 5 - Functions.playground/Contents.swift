//: Playground - noun: a place where people can play

import UIKit

let newLine = "\n"
var people = ["LLMV MASTER", "Obj-C Old Programmer", "Swift Programmer"]

//func sayHello(toPersonWithName name:String) -> String {
//    return "Hello, \(name) !"
//}
//
//let simpleHello = sayHello
//
//
//simpleHello(toPersonWithName: "Javier")

func createGreeting (withGreeting greeting: String) -> (String) -> String{
    func flexibleGreeting(name: String) -> String {
        return "\(greeting), \(name)"
    }
    return flexibleGreeting
}

func getNumberDescription (withNumber number: Int) -> (String) {
    switch number {
    case 1:
        return "First"
    case 2:
        return "Second"
    case 3:
        return "Third"
    case 4:
        return "Fourth"
    default:
        return "n"
    }
}

func getLatestNumberDescription (withNumber number: Int) -> (String) {
    switch number {
    case 7:
        return "Seventh"
    case 8:
        return "Eight"
    case 9:
        return "Ninght"
    case 10:
        return "Tenth"
    default:
        return "n"
    }
}


let hello = createGreeting(withGreeting: "Hello")
let bye = createGreeting(withGreeting: "Bye")
let hey = createGreeting(withGreeting: "Hey")

hello("Javier")

func greet(toPeopleCalled people:[String], withMessage message: (String)->String) -> String {
    var tempGreeting = ""
    var count = 1
    for person in people {
        tempGreeting = tempGreeting + message(person) + ", the \(getNumberDescription(withNumber:count)) in the list" + newLine
        count += 1
    }
    
    return tempGreeting
}

greet(toPeopleCalled: people, withMessage: hello)




func enumeratePeople(toPeopleCalled people:[String], #startNumber: Int,  withEnumeration enumeration: (Int)->String) -> String {
    var tempEnum = ""
    var count = startNumber
    for person in people {
        tempEnum = tempEnum + enumeration(count) + ". \(person)" + newLine
        count += 1
    }
    
    return tempEnum
}

let first = getNumberDescription
let last = getLatestNumberDescription

enumeratePeople(toPeopleCalled: people, startNumber: 1,  withEnumeration: first)
enumeratePeople(toPeopleCalled: people, startNumber: 7,  withEnumeration: last)
