public enum GoalEnergyTypePostfix: CaseIterable {
    case bmr
    case tdee
}

extension GoalEnergyTypePostfix: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .bmr: return "Base Metabolic Rate (BMR)"
        case .tdee: return "Total Daily Energy Expenditure (TDEE)"
        }
    }
}

public extension GoalEnergyTypePostfix {
    var acronym: String {
        switch self {
        case .bmr: return "BMR"
        case .tdee: return "TDEE"
        }
    }
    
    static var all: [String] {
        allCases.map { $0.description }
    }
}
