import Foundation

public extension Biometrics {
    var updatesWithHealthApp: Bool {
        //TODO: Biometrics
//        return true
        return restingEnergy?.source == .health
        || activeEnergy?.source == .health
        || leanBodyMass?.source == .health
        || weight?.source == .health
    }
}

public extension Biometrics {
    
    var hasTDEE: Bool {
        tdee != nil
    }
    
    var formattedTDEEWithUnit: String? {
        //TODO: Biometrics
//        nil
        guard let tdee, let energyUnit = restingEnergy?.unit else {
            return nil
        }
        return "\(tdee.formattedEnergy) \(energyUnit.shortDescription)"
    }

}

public extension Biometrics {
    
    var syncsRestingEnergy: Bool {
        switch restingEnergy?.source {
        case .health:
            return true
        case .equation:
            guard let equation = restingEnergy?.equation else { return false }
            if equation.usesLeanBodyMass, syncsLeanBodyMass {
                return syncsLeanBodyMass
            } else {
                return syncsWeight
            }
        default:
            return false
        }
    }
    
    var syncsActiveEnergy: Bool {
        switch activeEnergy?.source {
        case .health:
            return true
        default:
            return false
        }
    }
    
    var syncsMaintenanceEnergy: Bool {
        syncsRestingEnergy || syncsActiveEnergy
    }
    
    var syncsLeanBodyMass: Bool {
        switch leanBodyMass?.source {
        case .health:
            return true
        case .fatPercentage, .equation:
            /// We purposely disregard height being synced as it hardly changes after age 18-20
            return syncsWeight
        default:
            return false
        }
    }
    
    var syncsWeight: Bool {
        weight?.source == .health
    }
    
    var syncsHeight: Bool {
        height?.source == .health
    }

    func weight(in other: BodyMassUnit) -> Double? {
        guard let amount = weight?.amount,
              let unit = weight?.unit
        else { return nil }

        return unit.convert(amount, to: other)
    }
    
    func lbm(in other: BodyMassUnit) -> Double? {
        guard let amount = leanBodyMass?.amount,
              let unit = leanBodyMass?.unit

        else { return nil }

        return unit.convert(amount, to: other)
    }

    func tdee(in energyUnit: EnergyUnit) -> Double? {
        guard let tdeeInKcal else { return nil }
        return EnergyUnit.kcal.convert(tdeeInKcal, to: energyUnit)
//        return energyUnit == .kcal ? tdeeInKcal : tdeeInKcal * KcalsPerKilojule
    }

    var tdee: Double? {
        guard let restingEnergy = restingEnergy?.amount,
              let activeEnergy = activeEnergy?.amount
        else { return nil }

        return restingEnergy + activeEnergy
    }
    
    var tdeeInKcal: Double? {
        guard let tdee,
              let unit = restingEnergy?.unit
        else { return nil }

        return unit.convert(tdee, to: .kcal)
    }
}
