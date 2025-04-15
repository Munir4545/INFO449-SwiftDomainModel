struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount : Int
    var currency : String
    
    enum Currency: String {
        case USD
        case GBP
        case EUR
        case CAN
    }
    
    init(amount: Int, currency: String) {
        self.amount = amount
        if Currency(rawValue: currency) != nil {
            self.currency = currency
        } else {
            self.currency = "INVALID"
        }
    }
    
    func convert(_ curr: String) -> Money {
        // first normalize our currency with usd
        
        var convertCurrency = Double(self.amount)
        if self.currency == "USD" {
            convertCurrency *= 1.0
        } else if self.currency == "GBP" {
            convertCurrency *= 2
        } else if self.currency == "EUR" {
            convertCurrency *= (1.0 / 1.5)
        } else if self.currency == "CAN" {
            convertCurrency *= (1.0 / 1.25)
        }
        
        if curr == "USD" {
            convertCurrency *= 1.0
        } else if curr == "GBP" {
            convertCurrency *= 0.5
        } else if curr == "EUR" {
            convertCurrency *= 1.5
        } else if curr == "CAN" {
            convertCurrency *= 1.25
        }
        
        return Money(amount: Int(convertCurrency), currency: curr)
    }
    
    func add(_ money: Money) -> Money {
        let convertedCurrency = self.convert(money.currency)
        return Money(amount: convertedCurrency.amount + money.amount, currency: money.currency)
    }
    
    func subtract(_ money: Money) -> Money {
        let convertedCurrency = self.convert(money.currency)
        return Money(amount: convertedCurrency.amount - money.amount, currency: money.currency)
    }
}


////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var title : String
    var type : JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome(_ time: Int) -> Int {
        if case .Hourly(let double) = type {
            return time * Int(double)
        } else if case .Salary(let uInt) = type {
            return Int(uInt)
        }
        return 0
    }
    
    func raise(byAmount amount: Int) {
        if case .Hourly(let double) = type {
            self.type = JobType.Hourly(double + Double(amount))
        } else if case .Salary(let uInt) = type {
            self.type = JobType.Salary(uInt + UInt(amount))
        }
    }
    
    func raise(byAmount amount: Double) {
        if case .Hourly(let double) = type {
            self.type = JobType.Hourly(double + amount)
        } else if case .Salary(let uInt) = type {
            self.type = JobType.Salary(uInt + UInt(amount))
        }
    }
    
    func raise(byPercent perc: Double) {
        if case .Hourly(let double) = type {
            self.type = JobType.Hourly(double + (double * Double(perc)))
        } else if case .Salary(let amount) = type {
            self.type = JobType.Salary(amount + UInt(Double(amount) * perc))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    private var _job: Job?
    private var _spouse: Person?
    
    var job : Job? {
        set {
            if age > 15 {
                self.job = newValue
            }
        } get {
            return self._job
        }
    }
    var spouse : Person? {
        set {
            if age > 15 {
                self.spouse = newValue
            }
        } get {
            return self._spouse
        }
    }
    
    init(firstName : String, lastName : String, age : Int) {
        self.age = age
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func toString() -> String{
        var output = ""
        output += "[Person: firstName:" + self.firstName
        output += " lastName:" + self.lastName
        output += " age:" + String(self.age)
        
        output += " job:"
        if self.job == nil {
            output += "nil"
        } else if case .Hourly(let double) = job?.type {
            output += "Hourly(" + String(double) + ")"
        } else if case .Salary(let uInt) = job?.type {
            output += "Salary(" + String(uInt) + ")"
        }
        
        if spouse == nil {
            output += " spouse:nil"
        } else {
            output += " spouse:" + spouse!.firstName
        }
    
        output += "]"
        return output
    }
}

////////////////////////////////////
// Family
//
public class Family {
}
