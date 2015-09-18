import Foundation

var coffeeDrinks = ["Drip", "Expresso", "Capuccino","Mocka","Latte"]

func empatize(#words : [String]) -> [String] {
    var tempArray = [String]()
    for element in words {
        tempArray.append(element.uppercaseString)
    }
    return tempArray
}

//coffeeDrinks = empatize(words: coffeeDrinks)

//empatize(words: coffeeDrinks)

// Section 2 - Variable Parameters

// By default parameters are constants, but we can add var keyword and change their values

func empatizeVar(var #words : [String]) -> [String] {
    for element in words {
        element.uppercaseString
    }
    return words
}

coffeeDrinks
coffeeDrinks = empatize(words: coffeeDrinks)
coffeeDrinks

// Section 3 - In Oot Parameters

func downcase(inout #words : [String]) {
    for i in 0 ..< words.count {
        words[i] = words[i].lowercaseString
    }
}

downcase(words: &coffeeDrinks)

coffeeDrinks

// Section 4 - closure expressions

func empatizeClosure(inout #words : [String], #byApplyingModification : (String)->String) {
    for i in 0 ..< words.count {
        words[i] = byApplyingModification(words[i])
    }
}

func upperCase(phrase: String) ->String {
    return phrase.uppercaseString
}

empatizeClosure(words: &coffeeDrinks, byApplyingModification: upperCase)
coffeeDrinks

empatizeClosure(words: &coffeeDrinks, byApplyingModification: {(phrase:String)->String in return phrase + "!"})
coffeeDrinks

// Section 5 - Variations 

// “If a closure expression is the last argument for a function, we can move it outside of the parentheses.

func empatizeClosureV(inout words:[String], #byApplyingModification : (String)->String) {
    for i in 0 ..< words.count {
        words[i] = byApplyingModification(words[i])
    }
}

// current call
empatizeClosureV(&coffeeDrinks, byApplyingModification: {(phrase: String) -> String in return phrase + "?"})

empatizeClosureV(&coffeeDrinks) {(phrase:String)->String in return phrase + "!"}
coffeeDrinks

/// “Swift can infer that phrase is a String and the return type is a String and we can further shorten our closure expression. It's so short, we can type it on one line"
//In fact, we can eliminate the parentheses around the parameters in the closure expression. In addition, since the closure only has one expression, we can eliminate the keyword return

empatizeClosureV(&coffeeDrinks) {phrase in phrase + "!"}

// “ If you want to take this simplification one step further, Swift uses $0, $1, and so on as placeholder names for the parameters.”

empatizeClosureV(&coffeeDrinks) {$0 + "!"}


coffeeDrinks

// Section 6 - Generics 

var beers = ["Imperial", "Tumba Calzones", "Mama Candela", "Pelona", "Iron Maiden"]
var numbers = [5, 1, 4, 8, 2, 7]

func empatizeGenerics<T>(inout array:[T], modification : (T) -> T) {
    for i in 0 ..< array.count {
        array[i] = modification(array[i])
    }
}

empatizeGenerics(&beers) {phrase in phrase + "!"}
beers

empatizeGenerics(&beers) {(phrase: String) -> String in return  phrase + "?"}
beers

empatizeGenerics(&numbers) {number in number * 10}
numbers

// Section 7 Array's Map Function 


var coffeeDrinksMap = ["Drip", "Espresso", "Americano", "Cappuccino", "Latte"]
var numbersMap = [5, 1, 4, 8, 2, 7]

let emphasizedNumbersMap = numbersMap.map{a in "\(a)!"}
let emphasizedNumbersMap2 = numbersMap.map{(a: Int)->String in return "\(a)?"}
let emphasizedNumbersMap3 = numbersMap.map{a in return a*10}



numbersMap                                                              // [5, 1, 4, 8, 2, 7]
emphasizedNumbersMap                                  // ["5!", "1!", "4!", "8!", "2!", "7!"]”
emphasizedNumbersMap2
emphasizedNumbersMap3

// Section 8 Mutating Functions 

// There are 2 functions for sorting arrays: sorted() and sort()

var numbersS = [5,1,4,8,2,7]

func sortInternal(a: Int, b:Int) -> Bool {
    return a < b
}

let sortedNumbers = numbers.sorted{a,b in a < b}

// Mutating functions as Sort are defined with keyword mutating, and they changes the receiver, these functions don't return anything. 


// Section 9 - Extensions 

// Here is how we used to call emphatize: emphatize(&numbers) {number in number *100}


var coffeeDrinksExt = ["Drip", "Expresso", "Capuccino","Mocka","Latte"]
var numbersExt = [5, 1, 4, 8, 2, 7]

extension Array {
 // Compare to previous implementation of emphasize
//    func empatizeGenerics<T>(inout array:[T], modification : (T) -> T) {
//        for i in 0 ..< array.count {
//            array[i] = modification(array[i])
//        }
//    }

    // 1. Add mutating keyword 
    // 2. Can't use <T> since is the type inferred from Array's ext. 
    // 3. don't need the array as parameter - remove it 
    // 4. We keep T since is type in array's element
    mutating func empasize(modification: (T)->T) {
        for i in 0 ..< self.count {
            self[i] = modification(self[i])
        }
    }
}

coffeeDrinksExt.empasize{phrase in phrase + "?"}
coffeeDrinksExt
numbersExt.empasize{number in number * 100}
numbersExt

// Section 10 - Functional Programming 


// Usually Funcional Programming tend to avoid mutable objects, we prefer using inmutable objects in order to avoid side effects (like inout params)


extension Array {
    func emphasizeInmutable(modification: (T) -> T) -> [T]{
        return map{element in modification(element)}
    }
}
let numbersIn = [5, 1, 4, 8, 2, 7]
let coffeDrinksInmutable = ["Drip", "Expresso", "Capuccino","Mocka","Latte"]

let test = numbersIn.emphasizeInmutable{$0 * 10}
test

