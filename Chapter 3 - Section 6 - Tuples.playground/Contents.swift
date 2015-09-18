//: Playground - noun: a place where people can play

import UIKit

let newLine = "\n"
var people = ["LLMV MASTER", "Obj-C Old Programmer", "Swift Programmer"]


var str = "Hello, playground"

func createGreeting (withGreeting greeting: String) -> (String) -> String{
    func flexibleGreeting(name: String) -> String {
        return "\(greeting), \(name)"
    }
    return flexibleGreeting
}

let hello = createGreeting(withGreeting: "Hello")
let bye = createGreeting(withGreeting: "Bye")
let hey = createGreeting(withGreeting: "Hey")


func greet(theFollowingPeople folks:[String],    withMessage message:(String) -> String) -> (numberOfPeople: Int, message: String) {
        var temporaryGreeting = ""
        for folk in folks {
            temporaryGreeting = temporaryGreeting + message(folk) + newLine
        }
        return (folks.count, temporaryGreeting)
}

let results = greet(theFollowingPeople: people, withMessage: hello)
results.numberOfPeople
results.message


let (numberOfPeople, fullMessage) = greet(theFollowingPeople: people, withMessage: hey)
numberOfPeople
fullMessage

let (numberOfPeopleInResults, _) = results

numberOfPeopleInResults

