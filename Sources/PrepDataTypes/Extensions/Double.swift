import Foundation

public extension Double {
    var cleanedAmount: (string: String, isKilo: Bool) {
        let isKilo = self >= 1000
        let amountString: String
        if isKilo {
            amountString = (self/1000.0).cleanAmount
        } else {
            amountString = self.cleanAmount
        }
        return (amountString, isKilo)
    }
    
    var cleanedMilliliters: String {
        "\(cleanedAmount.string) \(cleanedAmount.isKilo ? "" : "m")L"
    }
    
    var cleanedGrams: String {
        "\(cleanedAmount.string) \(cleanedAmount.isKilo ? "k" : "")g"
    }
    
    func cleanedQuantity(unit: String, amount: Double = 1.0, lowercased: Bool = true) -> String {
        "\(cleanedAmount.string)\(cleanedAmount.isKilo ? "k" : "") \(unit.unitString(for: amount, lowercased: lowercased))"
    }
}

public extension Double {
    /// uses commas, rounds it off
    var formattedEnergy: String {
        let rounded = self.rounded()
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: Int(rounded))
        
        guard let formatted = numberFormatter.string(from: number) else {
            return "\(Int(rounded))"
        }
        return formatted
    }
    
    /// no commas, but rounds it off
    var formattedMacro: String {
        "\(Int(self.rounded()))"
    }
    
    /// commas, only rounded off if greater than 100, otherwise 1 decimal place
    var formattedGoalValue: String {
        if self >= 100 {
            let rounded = self.rounded()
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let number = NSNumber(value: Int(rounded))
            
            guard let formatted = numberFormatter.string(from: number) else {
                return "\(Int(rounded))"
            }
            return formatted
        } else {
            return self.rounded(toPlaces: 1).cleanAmount
        }
    }

}
