import Foundation

public struct Biometrics: Hashable, Codable {

    public var restingEnergy: RestingEnergy?
    public var activeEnergy: ActiveEnergy?
    public var fatPercentage: Double?
    public var leanBodyMass: LeanBodyMass?
    public var weight: Weight?
    public var height: Height?
    public var sex: Sex?
    public var age: Age?
    
    public init(
        restingEnergy: RestingEnergy? = nil,
        activeEnergy: ActiveEnergy? = nil,
        fatPercentage: Double? = nil,
        leanBodyMass: LeanBodyMass,
        weight: Weight,
        height: Height,
        sex: Sex,
        age: Age
    ) {
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