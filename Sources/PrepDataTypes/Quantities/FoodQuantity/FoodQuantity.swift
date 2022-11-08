import Foundation

public struct FoodQuantity {
    public let value: Double
    public let unit: FormUnit
    public let food: Food
    
    public init(amount: Double, unit: FormUnit, food: Food) {
        self.value = amount
        self.unit = unit
        self.food = food
    }
}

public extension FoodQuantity {
    
    indirect enum Unit: Hashable {
        case weight(WeightUnit)
        case volume(VolumeExplicitUnit)
        case size(Size, VolumeExplicitUnit?)
        case serving
    }

    struct Size: Hashable {
        let quantity: Double
        let volumePrefixExplicitUnit: VolumeExplicitUnit?
        let name: String
        let value: Double
        let unit: Unit
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

    init(_ value: Double, _ volumeUnit: VolumeUnit, food: Food) {
        self.init(
            amount: value,
            unit: .volume(volumeUnit),
            food: food
        )
    }

    init(_ value: Double, _ volumeExplicitUnit: VolumeExplicitUnit, food: Food) {
        self.init(
            amount: value,
            unit: .volume(volumeExplicitUnit.volumeUnit),
            food: food
        )
    }
}

extension FoodQuantity: CustomStringConvertible {
    public var description: String {
        "\(value.cleanAmount) \(unit.shortDescription)"
    }
}
