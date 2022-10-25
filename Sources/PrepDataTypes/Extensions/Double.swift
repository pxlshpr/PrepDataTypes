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
