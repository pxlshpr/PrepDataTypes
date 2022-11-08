import Foundation

public struct FoodValue: Codable, Hashable {
    public var value: Double
    public var unitType: UnitType
    public var weightUnit: WeightUnit?
    public var volumeExplicitUnit: VolumeExplicitUnit?
    public var sizeUnitId: String?
    public var sizeUnitVolumePrefixExplicitUnit: VolumeExplicitUnit?
    
    public init(value: Double, unitType: UnitType, weightUnit: WeightUnit? = nil, volumeExplicitUnit: VolumeExplicitUnit? = nil, sizeUnitId: String? = nil, sizeUnitVolumePrefixExplicitUnit: VolumeExplicitUnit? = nil) {
        self.value = value
        self.unitType = unitType
        self.weightUnit = weightUnit
        self.volumeExplicitUnit = volumeExplicitUnit
        self.sizeUnitId = sizeUnitId
        self.sizeUnitVolumePrefixExplicitUnit = sizeUnitVolumePrefixExplicitUnit
    }
}

public extension FoodValue {
    init(_ amount: Double, _ unit: WeightUnit) {
        self.init(.init(value: amount, unit: unit))
    }
    
    init(_ amount: Double, _ unit: VolumeExplicitUnit) {
        self.init(.init(value: amount, unit: unit))
    }
    
    init(_ weight: WeightQuantity) {
        self.init(
            value: weight.value,
            unitType: .weight,
            weightUnit: weight.unit
        )
    }
    
    init(_ volume: VolumeQuantity) {
        self.init(
            value: volume.value,
            unitType: .volume,
            volumeExplicitUnit: volume.unit
        )
    }
}

public extension FoodValue {
    func validate(within foodInfo: FoodInfo) throws {
        
        guard value > 0 else {
            throw FoodValueError.nonPositiveValue
        }
        
        /// if `unitType`is serving, the rest should be `nil`
        if unitType == .serving {
            guard weightUnit == nil, volumeExplicitUnit == nil, sizeUnitId == nil, sizeUnitVolumePrefixExplicitUnit == nil else {
                throw FoodValueError.extraneousUnits
            }
        }

        /// if `unitType`is weight, we should have a `weightUnit`, and the rest should be `nil`
        if unitType == .weight {
            guard weightUnit != nil else {
                throw FoodValueError.missingWeightUnit
            }
            guard volumeExplicitUnit == nil, sizeUnitId == nil, sizeUnitVolumePrefixExplicitUnit == nil else {
                throw FoodValueError.extraneousUnits
            }
        }
        
        /// if `unitType`is volume, we should have a `volumeExplicitUnit`, and the rest should be `nil`
        if unitType == .volume {
            guard volumeExplicitUnit != nil else {
                throw FoodValueError.missingVolumeUnit
            }
            guard weightUnit == nil, sizeUnitId == nil, sizeUnitVolumePrefixExplicitUnit == nil else {
                throw FoodValueError.extraneousUnits
            }
        }

        ///  if `unitType` is size
        if unitType == .size {
            /// we should have a `sizeUnitId`
            guard let sizeUnitId else {
                throw FoodValueError.missingSizeUnitId
            }

            /// we should have a size matched that `sizeUnitId`
            guard let size = foodInfo.sizes.size(for: sizeUnitId) else {
                throw FoodValueError.invalidSizeId
            }
            
            /// if the size is volume-prefixed
            if size.volumePrefixExplicitUnit != nil {
                /// we should have a `sizeUnitVolumePrefixExplicitUnit` specified
                guard sizeUnitVolumePrefixExplicitUnit != nil else {
                    throw FoodValueError.missingSizeVolumePrefixUnit
                }
            } else {
                /// otherwise, we shouldn't have a `sizeUnitVolumePrefixExplicitUnit`
                guard sizeUnitVolumePrefixExplicitUnit == nil else {
                    throw FoodValueError.extraneousUnits
                }
            }
            
            /// we shouldn't have a `weightUnit` or a `volumeExplicitUnit` specified
            guard weightUnit == nil, volumeExplicitUnit == nil else {
                throw FoodValueError.extraneousUnits
            }
        }
    }
}

public extension FoodValue {
    func unitDescription(sizes: [FoodSize]) -> String {
        switch self.unitType {
        case .serving:
            return "serving"
        case .weight:
            guard let weightUnit else {
                return "invalid weight"
            }
            return weightUnit.shortDescription
        case .volume:
            guard let volumeUnit = volumeExplicitUnit?.volumeUnit else {
                return "invalid volume"
            }
            return volumeUnit.shortDescription
        case .size:
            guard let size = sizes.sizeMatchingUnitSizeInFoodValue(self) else {
                return "invalid size"
            }
            if let volumePrefixUnit = size.volumePrefixExplicitUnit?.volumeUnit {
                return "\(volumePrefixUnit.shortDescription) \(size.name)"
            } else {
                return size.name
            }
        }
    }
}

public extension FoodValue {

    func foodSizeUnit(in food: Food) -> FoodSize? {
        food.info.sizes.first(where: { $0.id == self.sizeUnitId })
    }
    
    func formSizeUnit(in food: Food) -> FormSize? {
        guard let foodSize = foodSizeUnit(in: food) else {
            return nil
        }
        return FormSize(foodSize: foodSize, in: food.info.sizes)
    }
    
    func isWeightBased(in food: Food) -> Bool {
        unitType == .weight || hasWeightBasedSizeUnit(in: food)
    }

    func isVolumeBased(in food: Food) -> Bool {
        unitType == .volume || hasVolumeBasedSizeUnit(in: food)
    }
    
    func hasVolumeBasedSizeUnit(in food: Food) -> Bool {
        formSizeUnit(in: food)?.isVolumeBased == true
    }
    
    func hasWeightBasedSizeUnit(in food: Food) -> Bool {
        formSizeUnit(in: food)?.isWeightBased == true
    }
}

public enum FoodValueError: Error {
    case nonPositiveValue
    case extraneousUnits
    case missingWeightUnit
    case missingVolumeUnit
    case missingSizeUnitId
    case invalidSizeId
    case missingSizeVolumePrefixUnit
}
