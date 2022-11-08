import Foundation

public struct FoodQuantity {
    public let value: Double
    public let unit: Unit
    public let food: Food
    
    public init(amount: Double, unit: Unit, food: Food) {
        self.value = amount
        self.unit = unit
        self.food = food
    }
}

//MARK: - Convenience

public extension FoodQuantity {
    init(_ value: Double, _ weightUnit: WeightUnit, food: Food) {
        self.init(
            amount: value,
            unit: .weight(weightUnit),
            food: food
        )
    }

    init(_ value: Double, _ volumeExplicitUnit: VolumeExplicitUnit, food: Food) {
        self.init(
            amount: value,
            unit: .volume(volumeExplicitUnit),
            food: food
        )
    }
}

extension FoodQuantity: CustomStringConvertible {
    public var description: String {
        "\(value.cleanAmount) (unit)"
    }
}
