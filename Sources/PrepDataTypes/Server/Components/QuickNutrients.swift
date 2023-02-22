import Foundation

public struct QuickNutrients: Codable, Hashable {
    public let energy: EnergyValue?
    public let macros: [MacroValue]?
    public let micros: [MicroValue]?
    
    public init(energy: EnergyValue?, macros: [MacroValue]?, micros: [MicroValue]?) {
        self.energy = energy
        self.macros = macros
        self.micros = micros
    }
}
