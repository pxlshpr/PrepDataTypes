import Foundation

public struct FoodQuantity {
    public let amount: Double
    public let unit: FormUnit
    public let food: Food
    
    public init(amount: Double, unit: FormUnit, food: Food) {
        self.amount = amount
        self.unit = unit
        self.food = food
    }
}

extension FoodQuantity: CustomStringConvertible {
    public var description: String {
        "\(amount.cleanAmount) \(unit.shortDescription)"
    }
}
