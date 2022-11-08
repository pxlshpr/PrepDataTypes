import Foundation

public struct WeightQuantity: Hashable, Equatable {
    let value: Double
    let unit: WeightUnit
    
    /// Note: Equality is determined by comparing values to **two decimal places**
    public static func ==(lhs: WeightQuantity, rhs: WeightQuantity) -> Bool {
        lhs.unit == rhs.unit
        && lhs.value.rounded(toPlaces: 2) == rhs.value.rounded(toPlaces: 2)
    }

    var valueInGrams: Double {
        value * unit.g
    }
    
    func convert(to weightUnit: WeightUnit) -> Double {
        valueInGrams / weightUnit.g
    }
}
