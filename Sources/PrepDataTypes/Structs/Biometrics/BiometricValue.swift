import Foundation

public struct BiometricValue {
    public var amount: Double
    public var unit: BiometricUnit?
    
    public init(amount: Double, unit: BiometricUnit? = nil) {
        self.amount = amount
        self.unit = unit
    }
    
    public var description: String {
        guard let unit else {
            return amount.cleanAmount
        }
        switch unit {
        case .energy:
            return amount.formattedEnergy
        case .height:
            return amount.cleanAmount
        case .weight:
            return amount.cleanAmount
        }
    }
    
    public var unitDescription: String? {
        unit?.description
    }
}
