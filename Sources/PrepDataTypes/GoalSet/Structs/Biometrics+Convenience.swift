import Foundation

public extension Biometrics {
    var updatesWithHealthApp: Bool {
        //TODO: Biometrics
        return true
//        return restingEnergy?.source == .healthApp
//        || activeEnergy?.source == .healthApp
//        || leanBodyMass?.source == .healthApp
//        || weight?.source == .healthApp
    }
}

public extension Biometrics {
    
    var hasTDEE: Bool {
        tdeeInUnit != nil
    }
    
    var tdeeInUnit: Double? {
        tdee
    }
    var formattedTDEEWithUnit: String? {
        //TODO: Biometrics
        nil
//        guard let tdeeInUnit,
//              let energyUnit = restingEnergy?.unit
//        else { return nil }
//        return "\(tdeeInUnit.formattedEnergy) \(energyUnit.shortDescription)"
    }

}

public extension Biometrics {
    
    var hasDynamicRestingEnergy: Bool {
        //TODO: Biometrics
        true
//        switch restingEnergy?.source {
//        case .healthApp:
//            return true
//        case .formula:
//            guard let formula = restingEnergy?.formula else { return false }
//            if formula.usesLeanBodyMass, hasDynamicLBM {
//                return hasDynamicLBM
//            } else {
//                return hasDynamicWeight
//            }
//        default:
//            return false
//        }
    }
    
    var hasDynamicActiveEnergy: Bool {
        //TODO: Biometrics
        true
//        switch activeEnergy?.source {
//        case .healthApp:
//            return true
//        default:
//            return false
//        }
    }
    
    var hasDynamicTDEE: Bool {
        hasDynamicRestingEnergy || hasDynamicActiveEnergy
    }
    
    var hasDynamicLBM: Bool {
        //TODO: Biometrics
        true
//        switch leanBodyMass?.source {
//        case .healthApp:
//            return true
//        case .fatPercentage, .formula:
//            /// We don't care about the height being dynamic as it hardly changes after age 18-20
//            return hasDynamicWeight
//        default:
//            return false
//        }
    }
    
    var hasDynamicWeight: Bool {
        //TODO: Biometrics
        true
//        weight?.source == .healthApp
    }
    
    func weight(in other: WeightUnit) -> Double? {
        //TODO: Biometrics
        nil
//        guard let amount = weight?.amount,
//              let unit = weight?.unit
//        else { return nil }
//
//        return unit.convert(amount, to: other)
    }
    
    func lbm(in other: WeightUnit) -> Double? {
        //TODO: Biometrics
        nil
//        guard let amount = leanBodyMass?.amount,
//              let unit = leanBodyMass?.unit
//
//        else { return nil }
//
//        return unit.convert(amount, to: other)
    }

    func tdee(in energyUnit: EnergyUnit) -> Double? {
        guard let tdeeInKcal else { return nil }
        return EnergyUnit.kcal.convert(tdeeInKcal, to: energyUnit)
//        return energyUnit == .kcal ? tdeeInKcal : tdeeInKcal * KcalsPerKilojule
    }

    var tdee: Double? {
        //TODO: Biometrics
        nil
//        guard let restingEnergy = restingEnergy?.amount,
//              let activeEnergy = activeEnergy?.amount
//        else { return nil }
//
//        return restingEnergy + activeEnergy
    }
    
    var tdeeInKcal: Double? {
        //TODO: Biometrics
        nil
//        guard let tdee,
//              let unit = restingEnergy?.unit
//        else { return nil }
//
//        return unit.convert(tdee, to: .kcal)
    }
}
