import Foundation
import SwiftSugar

public struct FoodSize: Codable {
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

public extension FoodSize {
    func validate(within userFoodInfo: UserFoodInfo) throws {
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
    func validate(within userFoodInfo: UserFoodInfo) throws {
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
}

public enum FoodSizeError: Error {
    case duplicateSize
    case nonPositiveQuantity
    case amountError(FoodValueError)
    case volumePrefixProvidedForNonWeightBasedSize
}

