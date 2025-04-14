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
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
