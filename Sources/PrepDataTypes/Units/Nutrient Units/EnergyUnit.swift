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
    /**
     1 kcal = 4.184 kJ
     */
    static func convertToKilocalories(fromKilojules kJ: Double) -> Double {
        kJ / 4.184
    }
    
    static func convertToKilojules(fromKilocalories kcal: Double) -> Double {
        kcal * 4.184
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
        let sexIsFemale = params.bodyProfile?.sexIsFemale ?? false
        switch self {
        case .kcal:
            return sexIsFemale ? 1200 : 1500
        case .kJ:
            return sexIsFemale ? (1200 * KcalsPerKilojule) : (1500 * KcalsPerKilojule)
        }
    }
}
