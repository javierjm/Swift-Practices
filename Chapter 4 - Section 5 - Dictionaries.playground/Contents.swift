import Foundation

let numbers = ["one":1, "two":2, "three":3]

let moreNumbers:[String:Int]

moreNumbers = ["four"   : 4,
                "five"  : 5,
                "six"   : 6,
                "seven" : 7]


let moreNumbersKeys = moreNumbers.keys
let moreNumberValues = moreNumbers.values

for key in moreNumbers.keys {
    println("\(key) : \(moreNumbers[key]!)")
}

// Section 7 Modify Dictionaries 

var numbers1 = [String:Int]()
numbers1["one"] = 1
numbers1["two"] = 2

numbers1.count
numbers1

numbers1.removeValueForKey("too")
numbers1.removeValueForKey("two")
numbers1.removeValueForKey("one")
numbers1.count


// Section 8 - Optionals and Dictionaries

let numbers2 = ["one":1, "two":2]

//let one = numbers2["one"]
//let sum = 3 + one
//
//let four = numbers2["four"]
//3 + four

if let one = numbers["one"] {
    3 + one
} else {
    println("one is nil")
}

if let four = numbers["four"] {
    7 + four
} else {
    println("four is nil")
}


// Section 9  - Enumerate Dictionaries 

let numbers3 = ["one":1, "two":2, "three" : 3]

let keys = numbers.keys

for numberKey in keys {
    println("The value of \(numberKey) is \(numbers[numberKey]!)")
}

for (number, numeral) in numbers {
    println("The value of \(number) is \(numeral)")
}

numbers3



