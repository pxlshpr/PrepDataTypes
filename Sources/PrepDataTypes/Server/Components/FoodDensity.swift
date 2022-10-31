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
    func validate() throws {
        guard weightAmount > 0 else {
            throw FoodDensityError.nonPositiveWeight
        }
        guard volumeAmount > 0 else {
            throw FoodDensityError.nonPositiveVolume
        }
    }
}

public enum FoodDensityError: Error {
    case nonPositiveWeight
    case nonPositiveVolume
}
