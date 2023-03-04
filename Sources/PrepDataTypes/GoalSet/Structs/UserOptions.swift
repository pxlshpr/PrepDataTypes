import Foundation

public struct UserOptions: Hashable, Codable {
    public var energy: EnergyUnit
    public var weight: WeightUnit
    public var height: HeightUnit
    public var volume: UserExplicitVolumeUnits
    
    public static var standard: UserOptions {
        UserOptions(
            energy: .kcal,
            weight: .kg,
            height: .cm,
            volume: .defaultUnits
        )
    }
}
