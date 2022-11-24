import Foundation

public struct BodyProfile: Hashable, Codable {
    
    public let energyUnit: EnergyUnit
    public let weightUnit: WeightUnit
    public let heightUnit: HeightUnit

    public var restingEnergy: Double?
    public var restingEnergySource: RestingEnergySource?
    public var restingEnergyFormula: RestingEnergyFormula?
    public var restingEnergyPeriod: HealthPeriodOption?
    public var restingEnergyIntervalValue: Int?
    public var restingEnergyInterval: HealthAppInterval?

    public var activeEnergy: Double?
    public var activeEnergySource: ActiveEnergySource?
    public var activeEnergyActivityLevel: ActivityLevel?
    public var activeEnergyPeriod: HealthPeriodOption?
    public var activeEnergyIntervalValue: Int?
    public var activeEnergyInterval: HealthAppInterval?

    public var fatPercentage: Double?

    public var lbm: Double?
    public var lbmSource: LeanBodyMassSource?
    public var lbmFormula: LeanBodyMassFormula?
    public var lbmDate: Date?

    public var weight: Double?
    public var weightSource: MeasurementSource?
    public var weightDate: Date?

    public var height: Double?
    public var heightSource: MeasurementSource?
    public var heightDate: Date?

    public var sexIsFemale: Bool?
    public var sexSource: MeasurementSource?

    public var age: Int?
    public var dobDay: Int?
    public var dobMonth: Int?
    public var dobYear: Int?
    public var ageSource: MeasurementSource?
}

public extension BodyProfile {
    var updatesWithHealthApp: Bool {
        return restingEnergySource == .healthApp
        || activeEnergySource == .healthApp
        || lbmSource == .healthApp
        || weightSource == .healthApp
    }
}

public extension BodyProfile {
    
    var hasTDEE: Bool {
        tdeeInUnit != nil
    }
    
    var tdeeInUnit: Double? {
        tdee
    }
    var formattedTDEEWithUnit: String? {
        guard let tdeeInUnit else { return nil }
        return "\(tdeeInUnit.formattedEnergy) \(energyUnit.shortDescription)"
    }

}

public extension BodyProfile {
    
    var hasDynamicRestingEnergy: Bool {
        switch restingEnergySource {
        case .healthApp:
            return true
        case .formula:
            guard let restingEnergyFormula else { return false }
            if restingEnergyFormula.usesLeanBodyMass, hasDynamicLBM {
                return hasDynamicLBM
            } else {
                return hasDynamicWeight
            }
        default:
            return false
        }
    }
    
    var hasDynamicActiveEnergy: Bool {
        switch activeEnergySource {
        case .healthApp:
            return true
        default:
            return false
        }
    }
    
    var hasDynamicTDEE: Bool {
        hasDynamicRestingEnergy || hasDynamicActiveEnergy
    }
    
    var hasDynamicLBM: Bool {
        guard let lbmSource else { return false }
        switch lbmSource {
        case .healthApp:
            return true
        case .fatPercentage, .formula:
            /// We don't care about the height being dynamic as it hardly changes after age 18-20
            return hasDynamicWeight
        default:
            return false
        }
    }
    
    var hasDynamicWeight: Bool {
        weightSource == .healthApp
    }
    
    func weight(in other: WeightUnit) -> Double? {
        guard let weight else { return nil }
        return weightUnit.convert(weight, to: other)
    }
    
    func lbm(in other: WeightUnit) -> Double? {
        guard let lbm else { return nil }
        return weightUnit.convert(lbm, to: other)
    }

    func tdee(in energyUnit: EnergyUnit) -> Double? {
        guard let tdeeInKcal else { return nil }
        return energyUnit == .kcal ? tdeeInKcal : tdeeInKcal * KcalsPerKilojule
    }

    var tdee: Double? {
        guard let restingEnergy, let activeEnergy else { return nil }
        return restingEnergy + activeEnergy
    }
    
    var tdeeInKcal: Double? {
        guard let tdee else { return nil }
        if energyUnit == .kcal {
            return tdee
        } else {
            return tdee / KcalsPerKilojule
        }
    }
}
