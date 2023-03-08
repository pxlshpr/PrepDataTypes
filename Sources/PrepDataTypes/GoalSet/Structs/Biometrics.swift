import Foundation

public struct Biometrics: Hashable, Codable {

    //TODO: Remove these
    public let energyUnit: EnergyUnit
    public let weightUnit: WeightUnit
    public let heightUnit: HeightUnit

    public var restingEnergy: RestingEnergy?
    public var activeEnergy: ActiveEnergy?
    public var fatPercentage: Double?
    public var leanBodyMass: LeanBodyMass?
    public var weight: Weight?
    public var height: Height?
    public var sex: Sex?
    public var age: Age?
    
    public init(
        energyUnit: EnergyUnit,
        weightUnit: WeightUnit,
        heightUnit: HeightUnit,
        restingEnergy: RestingEnergy? = nil,
        activeEnergy: ActiveEnergy? = nil,
        fatPercentage: Double? = nil,
        leanBodyMass: LeanBodyMass,
        weight: Weight,
        height: Height,
        sex: Sex,
        age: Age
    ) {
        self.energyUnit = energyUnit
        self.weightUnit = weightUnit
        self.heightUnit = heightUnit
        
        self.restingEnergy = restingEnergy
        self.activeEnergy = activeEnergy
        self.fatPercentage = fatPercentage
        self.leanBodyMass = leanBodyMass
        self.weight = weight
        self.height = height
        self.sex = sex
        self.age = age
    }
}
