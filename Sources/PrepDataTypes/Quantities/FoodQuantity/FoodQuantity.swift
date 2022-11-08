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

extension FoodQuantity.Size {
    init?(foodSize: FoodSize, in food: Food) {
        guard let unit = FoodQuantity.Unit(foodValue: foodSize.value, in: food) else {
            return nil
        }
                
        self.init(
            quantity: foodSize.quantity,
            volumePrefixExplicitUnit: foodSize.volumePrefixExplicitUnit,
            name: foodSize.name,
            value: foodSize.value.value,
            unit: unit
        )
    }
}

extension FoodQuantity.Unit {
    init?(foodValue: FoodValue, in food: Food) {
        switch foodValue.unitType {
            
        case .serving:
            self = .serving
            
        case .weight:
            guard let weightUnit = foodValue.weightUnit else { return nil }
            self = .weight(weightUnit)
            
        case .volume:
            guard let volumeExplicitUnit = foodValue.volumeExplicitUnit else { return nil }
            self = .volume(volumeExplicitUnit)
            
        case .size:
            guard let foodSize = food.info.sizes.sizeMatchingUnitSizeInFoodValue(foodValue),
                  let size = FoodQuantity.Size(foodSize: foodSize, in: food)
            else { return nil }
            self = .size(size, foodValue.sizeUnitVolumePrefixExplicitUnit)
        }
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
