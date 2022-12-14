import Foundation

public struct UserUnits: Hashable, Codable {
    public var energy: EnergyUnit
    public var weight: WeightUnit
    public var height: HeightUnit
    public var volume: UserExplicitVolumeUnits
    
    public static var standard: UserUnits {
        UserUnits(
            energy: .kcal,
            weight: .kg,
            height: .cm,
            volume: .defaultUnits
        )
    }
}
