import Foundation

var coffeeDrinks = Array(count: 5, repeatedValue: "Capuccino")
var bicycles = Array(count: 5, repeatedValue: "Cannondale")

coffeeDrinks[0] = "Mockaccino"
coffeeDrinks.count
coffeeDrinks

coffeeDrinks[2...4] = ["Expresso", "Latte"]
coffeeDrinks.count
coffeeDrinks


if !coffeeDrinks.isEmpty {
    coffeeDrinks.removeLast()
}

coffeeDrinks


coffeeDrinks.append("Decaf")                    //                       ["Drip", "Decaf"]
coffeeDrinks = coffeeDrinks + ["Mocha"] + ["Las Nubes"]         //              ["Drip", "Decaf", "Mocha"]
coffeeDrinks += ["Cold Brew"] + ["Primavera"]                   // ["Drip", "Decaf", "Mocha", "Cold Brew"]
coffeeDrinks.count                              //                                       4
coffeeDrinks

coffeeDrinks.insert("Frensh Press", atIndex: 7)
coffeeDrinks


let firstIndex = 4
let lastIndex = coffeeDrinks.count - 1;

for i  in firstIndex..<lastIndex{
    coffeeDrinks.removeLast()
}

coffeeDrinks




// Section 4 Enumerate Arrays 

// Option 1 Traditional For 

func item(#number:Int) -> String {
    return "\n (\(number))"
}

var results = ""
for var index = 0; index < coffeeDrinks.count; index++ {
    results += item(number: index) + coffeeDrinks[index]
}

// Option 2
results = ""
for i in 0..<coffeeDrinks.count {
    results += item(number: i) + coffeeDrinks[i]
}

// Option 3
results = ""
for (index, kindOfDrink) in enumerate(coffeeDrinks) {
    results += item(number: index + 1) + kindOfDrink
}

// Section 5 - Dictionaries 


