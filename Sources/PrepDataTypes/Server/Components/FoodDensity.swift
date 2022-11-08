import Foundation

public struct FoodDensity: Codable, Hashable {
    public var weightAmount: Double
    public var weightUnit: WeightUnit
    public var volumeAmount: Double
    public var volumeExplicitUnit: VolumeExplicitUnit
    
    public init(weightAmount: Double, weightUnit: WeightUnit, volumeAmount: Double, volumeExplicitUnit: VolumeExplicitUnit) {
        self.weightAmount = weightAmount
        self.weightUnit = weightUnit
        self.volumeAmount = volumeAmount
        self.volumeExplicitUnit = volumeExplicitUnit
    }
}

public extension FoodDensity {
    init(_ weightAmount: Double, _ weightUnit: WeightUnit, _ volumeAmount: Double, _ volumeExplicitUnit: VolumeExplicitUnit) {
        self.init(
            weightAmount: weightAmount,
            weightUnit: weightUnit,
            volumeAmount: volumeAmount,
            volumeExplicitUnit: volumeExplicitUnit
        )
    }
}

public extension FoodDensity {
    func validate() throws {
        guard weightAmount > 0 else {
            throw FoodDensityError.nonPositiveWeight
        }
        guard volumeAmount > 0 else {
            throw FoodDensityError.nonPositiveVolume
        }
    }
}

//MARK: Conversions
/// ✅ Tests passing
public extension FoodDensity {
    func convert(weight: WeightQuantity) -> VolumeQuantity {
        /// Protect against divison by 0
        guard self.weightAmount > 0 else { return VolumeQuantity(value: 0, unit: volumeExplicitUnit) }
        
        /// first convert the weight to the unit we have in the density
        let convertedWeight = weight.convert(to: self.weightUnit)
        
        let volumeAmount = (convertedWeight * self.volumeAmount) / self.weightAmount
        return VolumeQuantity(value: volumeAmount, unit: self.volumeExplicitUnit)
    }
    
    func convert(volume: VolumeQuantity) -> WeightQuantity {
        /// Protect against divison by 0
        guard self.volumeAmount > 0 else { return WeightQuantity(value: 0, unit: weightUnit) }
        
        /// first convert the volume to the unit we have in the density
        let convertedVolume = volume.convert(to: self.volumeExplicitUnit)
        
        let weightAmount = (convertedVolume * self.weightAmount) / self.volumeAmount
        return WeightQuantity(value: weightAmount, unit: weightUnit)
    }
}

public enum FoodDensityError: Error {
    case nonPositiveWeight
    case nonPositiveVolume
}
