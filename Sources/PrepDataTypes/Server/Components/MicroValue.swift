import Foundation

public struct MicroValue: Codable {
    public let nutrientType: NutrientType
    public let amount: Double
    public let nutrientUnit: NutrientUnit
    
    public init(nutrientType: NutrientType, amount: Double, nutrientUnit: NutrientUnit) {
        self.nutrientType = nutrientType
        self.amount = amount
        self.nutrientUnit = nutrientUnit
    }
}
