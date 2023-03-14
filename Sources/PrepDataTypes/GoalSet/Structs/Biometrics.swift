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

public extension Biometrics {
    func updatedTypes(from other: Biometrics) -> [BiometricType] {
        var types: [BiometricType] = []
        if restingEnergy != other.restingEnergy {
            types.append(.restingEnergy)
        }
        if activeEnergy != other.activeEnergy {
            types.append(.activeEnergy)
        }
        if weight != other.weight {
            types.append(.weight)
        }
        if leanBodyMass != other.leanBodyMass {
            types.append(.leanBodyMass)
        }
        if height != other.height {
            types.append(.height)
        }
        if age != other.age {
            types.append(.age)
        }
        if sex != other.sex {
            types.append(.sex)
        }
        return types
    }
}
