public enum GoalEnergyTypePrefix: CaseIterable {
    case absolute
    case deficit
    case surplus
    case percentDeficit
    case percentSurplus
}

extension GoalEnergyTypePrefix: CustomStringConvertible {
    public var description: String {
        switch self {
        case .absolute: return "kcal"
        case .deficit: return "kcal deficit"
        case .surplus: return "kcal surplus"
        case .percentDeficit: return "% deficit"
        case .percentSurplus: return "% surplus"
        }
    }
}

public extension GoalEnergyTypePrefix {
    static var all: [String] {
        allCases.map { $0.description }
    }
}
