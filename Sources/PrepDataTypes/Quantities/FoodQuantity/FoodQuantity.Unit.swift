import Foundation

public extension FoodQuantity {
    
    indirect enum Unit: Hashable {
        case weight(WeightUnit)
        case volume(VolumeExplicitUnit)
        case size(Size, VolumeExplicitUnit?)
        case serving
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

public extension FoodQuantity.Unit {
    var sizeVolumePrefixExplicitUnit: VolumeExplicitUnit? {
        switch self {
        case .size(_, let volumeExplicitUnit):
            return volumeExplicitUnit
        default:
            return nil
        }
    }
}

extension FoodQuantity.Unit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .weight(let weightUnit):
            return weightUnit.description
        case .volume(let volumeUnit):
            return volumeUnit.description
        case .size(let size, let volumePrefixExplicitUnit):
            return size.namePrefixed(with: volumePrefixExplicitUnit)
        case .serving:
            return "serving"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .weight(let weightUnit):
            return weightUnit.shortDescription
        case .volume(let volumeUnit):
            return volumeUnit.shortDescription
        case .size(let size, let volumePrefixExplicitUnit):
            return size.namePrefixed(with: volumePrefixExplicitUnit)
        case .serving:
            return "serving"
        }
    }
}
