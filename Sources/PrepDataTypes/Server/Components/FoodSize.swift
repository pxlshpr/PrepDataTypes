import Foundation
import SwiftSugar

public struct FoodSize: Codable, Hashable {
    public var name: String
    public var volumePrefixExplicitUnit: VolumeExplicitUnit?
    public var quantity: Double
    public var value: FoodValue
    
    public var id: String {
        if let volumePrefixExplicitUnit {
            return "\(name)\(volumePrefixExplicitUnit.volumeUnit.rawValue)"
        } else {
            return name
        }
    }
    
    public init(name: String, volumePrefixExplicitUnit: VolumeExplicitUnit? = nil, quantity: Double, value: FoodValue) {
        self.name = name
        self.volumePrefixExplicitUnit = volumePrefixExplicitUnit
        self.quantity = quantity
        self.value = value
    }
}

extension FoodSize {
    /**
     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
     */
    func unitWeight(in food: Food) -> WeightQuantity? {
        /// Protect against zero-divison error
        guard quantity > 0 else { return nil }
        let unitValue = (value.value / quantity)
        
        switch value.unitType {
        case .weight:
            guard let weightUnit = value.weightUnit else { return nil }
            return WeightQuantity(value: unitValue, unit: weightUnit)
            
        case .volume:
            guard let volumeExplicitUnit = value.volumeExplicitUnit else { return nil }
            guard let density = food.info.density else { return nil }
            let volume = VolumeQuantity(value: unitValue, unit: volumeExplicitUnit)
            return density.convert(volume: volume)
        
        case .size:
            guard let sizeId = value.sizeUnitId,
                  let size = food.size(for: sizeId),
                  let unitWeightOfSize = size.unitWeight(in: food)
            else { return nil }
            return .init(value: unitValue * unitWeightOfSize.value, unit: unitWeightOfSize.unit)

        default:
            return nil
        }
//        switch unit {
//        case .serving:
//            guard let servingWeightQuantity = food.servingWeightQuantity else {
//                return nil
//            }
//
//            return FoodQuantity(
//                amount: (servingWeightQuantity.value * amount) / quantity,
//                unit: servingWeightQuantity.unit,
//                food: food
//            )
//
//        case .size(let sizeUnit, let volumePrefixUnit):
//            guard let unitWeightQuantity = sizeUnit.unitWeightQuantity(in: food) else {
//                return nil
//            }
//            return FoodQuantity(
//                amount: (unitWeightQuantity.value * amount) / quantity,
//                unit: unitWeightQuantity.unit,
//                food: food
//            )
//
//            //TODO: What do we do about the volumePrefixUnit
//        default:
//            return nil
//        }
    }
}

public extension FoodSize {
    func validate(within userFoodInfo: FoodInfo) throws {
        /// Check that the quantity is positive
        guard quantity > 0 else {
            throw FoodSizeError.nonPositiveQuantity
        }
        
        /// Make sure the value is `valid`
        do {
            try value.validate(within: userFoodInfo)
        } catch let foodValueError as FoodValueError {
            throw FoodSizeError.amountError(foodValueError)
        }
        
        if volumePrefixExplicitUnit != nil {
            guard value.unitType == .weight else {
                throw FoodSizeError.volumePrefixProvidedForNonWeightBasedSize
            }
        }
    }
}

public extension Array where Element == FoodSize {
    func validate(within userFoodInfo: FoodInfo) throws {
        guard map({$0.id}).isDistinct() else {
            throw FoodSizeError.duplicateSize
        }
        
        for size in self {
            try size.validate(within: userFoodInfo)
        }
    }
    
    func size(for sizeId: String) -> FoodSize? {
        first(where: { $0.id == sizeId })
    }

    func containsSize(with sizeId: String) -> Bool {
        contains(where: { $0.id == sizeId })
    }
    
    func sizeMatchingUnitSizeInFoodValue(_ foodValue: FoodValue) -> FoodSize? {
        first(where: { $0.id == foodValue.sizeUnitId })
    }
}

public enum FoodSizeError: Error {
    case duplicateSize
    case nonPositiveQuantity
    case amountError(FoodValueError)
    case volumePrefixProvidedForNonWeightBasedSize
}

