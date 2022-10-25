import Foundation

public struct FoodDensity: Codable {
    public var weightAmount: Double
    public var weightUnit: WeightUnit
    public var volumeAmount: Double
    public var volumeExplicitUnit: VolumeExplicitUnit
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
