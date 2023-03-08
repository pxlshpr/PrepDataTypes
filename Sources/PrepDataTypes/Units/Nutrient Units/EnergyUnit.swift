import Foundation

public enum EnergyUnit: Int16, CaseIterable, Codable {
    case kcal = 1
    case kJ
}

extension EnergyUnit: DescribableUnit {
    public var description: String {
        switch self {
        case .kcal:
            return "Kilocalorie"
        case .kJ:
            return "Kilojule"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .kcal:
            return "kcal"
        case .kJ:
            return "kJ"
        }
    }
    
    public func title(isPlural: Bool) -> String {
        description
    }
}

public extension EnergyUnit {
    func convert(_ value: Double, to unit: EnergyUnit) -> Double {
        switch self {
        case .kcal:
            switch unit {
            case .kcal:
                return value
            case .kJ:
                return value * KjPerKcal
            }
        case .kJ:
            switch unit {
            case .kcal:
                return value / KjPerKcal
            case .kJ:
                return value
            }
        }
    }
}

public extension EnergyUnit {
    var foodLabelUnit: FoodLabelUnit? {
        switch self {
        case .kcal:
            return .kcal
        case .kJ:
            return .kj
        }
    }
}

public extension EnergyUnit {
    func minimumValueForAutoGoals(params: GoalCalcParams) -> Double {
        /// Default to male in the case not being passed a value to err on the side of larger values
        /// (as we would rather suggest larger values than is required to a female than smaller values for a male's energy)
        let sexIsFemale = params.biometrics?.sexIsFemale ?? false
        let minimumKcal: Double = sexIsFemale ? 1200 : 1500
        return EnergyUnit.kcal.convert(minimumKcal, to: self)
//        switch self {
//        case .kcal:
//            return sexIsFemale ? 1200 : 1500
//        case .kJ:
//            return sexIsFemale ? (1200 * KcalsPerKilojule) : (1500 * KcalsPerKilojule)
//        }
    }
}
