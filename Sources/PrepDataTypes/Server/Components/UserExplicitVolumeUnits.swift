import Foundation

public struct UserExplicitVolumeUnits: Codable {
    public let cup: VolumeExplicitUnit
    public let teaspoon: VolumeExplicitUnit
    public let tablespoon: VolumeExplicitUnit
    public let fluidOunce: VolumeExplicitUnit
    public let pint: VolumeExplicitUnit
    public let quart: VolumeExplicitUnit
    public let gallon: VolumeExplicitUnit
    
    public init(cup: VolumeExplicitUnit, teaspoon: VolumeExplicitUnit, tablespoon: VolumeExplicitUnit, fluidOunce: VolumeExplicitUnit, pint: VolumeExplicitUnit, quart: VolumeExplicitUnit, gallon: VolumeExplicitUnit) {
        //TODO: Validate the values, making sure we're assigning a 'cup' unit to cup etc...
        self.cup = cup
        self.teaspoon = teaspoon
        self.tablespoon = tablespoon
        self.fluidOunce = fluidOunce
        self.pint = pint
        self.quart = quart
        self.gallon = gallon
    }
}
