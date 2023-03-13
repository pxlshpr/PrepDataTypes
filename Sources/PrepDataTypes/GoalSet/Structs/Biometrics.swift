import Foundation

public struct PreviousBiometrics: Hashable, Codable {
    public var biometrics: Biometrics
    public var didViewGoalsList: Bool
    public var didViewBiometrics: Bool

    public init(_ biometrics: Biometrics) {
        self.biometrics = biometrics
        self.didViewGoalsList = false
        self.didViewBiometrics = false
    }
}

public struct Biometrics: Hashable, Codable {

    public var timestamp: Double?
    public var restingEnergy: RestingEnergy?
    public var activeEnergy: ActiveEnergy?
    public var fatPercentage: Double?
    public var leanBodyMass: LeanBodyMass?
    public var weight: Weight?
    public var height: Height?
    public var sex: Sex?
    public var age: Age?
    
    public init(
        timestamp: Double? = nil,
        restingEnergy: RestingEnergy? = nil,
        activeEnergy: ActiveEnergy? = nil,
        fatPercentage: Double? = nil,
        leanBodyMass: LeanBodyMass? = nil,
        weight: Weight? = nil,
        height: Height? = nil,
        sex: Sex? = nil,
        age: Age? = nil
    ) {
        self.timestamp = timestamp
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
