import Foundation

public struct EnergyValue: Codable, Hashable {
    public let amount: Double
    public let energyUnit: EnergyUnit
    
    public init(amount: Double, energyUnit: EnergyUnit) {
        self.amount = amount
        self.energyUnit = energyUnit
    }
}
