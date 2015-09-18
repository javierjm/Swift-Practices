import UIKit



// Create a functions that receives a dictionary of T and a closure to append / increment anything to the end of each key value

var beerDict:[String:Double]

beerDict = ["Imperial":4.5,
        "Pilsen": 5.0,
        "Heineken": 3.9,
        "Bavaria": 4.0,
        "Bavaria Light": 1.9]

let beerKey = "Imperial"

let test = beerDict[beerKey]

if let alchoolLevel = beerDict[beerKey] {
    println("Exist an element called \(beerKey) and has an alchool level of \(alchoolLevel)")
} else {
    println("there isn't an element called \(beerKey)")
}


func increaseIngredients<T,U>(inout dict:[T:U], #modification:(U) -> U ) {
    for  dictKey in dict.keys {
        dict[dictKey] = modification(dict[dictKey]!)
    }
}

increaseIngredients(&beerDict){$0 + 2.1}

beerDict
// No sirve esta vara
//extension Dictionary {
//    mutating func increaseAlcohol(modification: (T)->T) {
//        for key in self.keys {
//            self[key] = modification(self[key]!)
//        }
//    }
//}
//
//
//beerDict.increaseAlcohol{$0 + 2.2}
//
//beerDict
