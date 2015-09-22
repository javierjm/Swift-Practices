// Section 1 - Nil Coalescing Operator 

let fortyHours = 40
var hourlyRate:Int?

func weeklyWage() -> Int {
    // here we validate hourlyRate is not nil before returning an Invalid value
    
//    if let hRate = hourlyRate {
//        return fortyHours * hRate
//    }else {
//        return 0
//    }
    
    // this is equivalent to this: 
    
    return fortyHours * (hourlyRate ?? 0)
    
    // it reads as ternary operator and is called COALESCING OPERATOR
    
    // return fortyHours * (hourlyRate != nil ? hourlyRate! : 0)
}

let test = weeklyWage()


// Section 2 - Coalescing Cocoa Types 


// let's include UIKit for working tiwh Cocoa Framework classes 

import UIKit

var primarCylor:UIColor?
var accentColor:UIColor?

// we can work with these clasess even when they aren't swift classes / structures, since they were created in Obj C 

let fillColor = (primarCylor ?? UIColor.yellowColor())
let strokeColor = (accentColor ?? UIColor.blueColor())


// Determining Types 

// Sometimes we need to know the type of an object 

let numberOfHoursInStandardWeek = 40

class Employee  {
    var hourlyWage: Int
    init(hourlyWage: Int) {
        self.hourlyWage = hourlyWage
    }
    
    func weeklyPay() -> Int {
        return 0
    }
}

class SalariedEmployee : Employee {

    override func weeklyPay() -> Int {
        return numberOfHoursInStandardWeek * hourlyWage
    }
}

class HourlyEmployee : Employee {
    var numberOfHours = 0
    
    override func weeklyPay() -> Int {
//        return numberOfHours * hourlyWage
        
    // Added for section 6
        switch numberOfHours {
        case 0 ... numberOfHoursInStandardWeek where hourlyWage < 50:
            return numberOfHours * hourlyWage + 30
        case numberOfHoursInStandardWeek ... (24 * 7):
            let overtimeHours = numberOfHours - numberOfHoursInStandardWeek
            return (numberOfHours + overtimeHours) * hourlyWage
        default:
            return numberOfHours * hourlyWage
            
        }
    }
}

func payedEmployee(employee: Employee) -> Int {
    if employee is SalariedEmployee {
        return numberOfHoursInStandardWeek * employee.hourlyWage
//    } else if employee is HourlyEmployee{
      } else if let hourlyEmployee = employee as? HourlyEmployee {
        // This still returns an error
        //        return employee.numnerOfHours * employee.hourlyWage
//            let hourlyEmployee = employee as? HourlyEmployee
            return hourlyEmployee.numberOfHours * hourlyEmployee.hourlyWage
    } else {
        return 0
    }
}

// Section 4 - Type Casting

// Use the is keyword to test whether an element of type Employee is more specifically of type HourlyEmployee.
// Use the as keyword to downcast an element of type Employee to be of type HourlyEmployee, like this.

// “        let hourlyEmployee = employee as HourlyEmployee


// Section 5 - Polymorphysm

// Added weeklyPay() method at Emplyee Class
// And ovveride theis method in subclasses 

// New version of payedEmployee Method 

func payEmployee (employee: Employee) -> Int {
    return employee.weeklyPay()
}



let manager = SalariedEmployee(hourlyWage: 100)
payEmployee(manager)                                                              // 4,000

let engineer = HourlyEmployee(hourlyWage: 60)
engineer.numberOfHours = 50
payEmployee(engineer)

// Section 6 


// we can add a where clause to a switch case statement that acts as a filter
let partTimeEngineer = HourlyEmployee(hourlyWage: 60)
partTimeEngineer.numberOfHours = 30
payEmployee(partTimeEngineer)                                                     // 1,800
let underpaidPartTimeEngineer = HourlyEmployee(hourlyWage: 40)
underpaidPartTimeEngineer.numberOfHours = 30
payEmployee(underpaidPartTimeEngineer)




