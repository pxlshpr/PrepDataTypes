import Foundation

public enum GoalSetType: Int16, Codable, Hashable {
    case day
    case meal
    
    public var description: String {
        switch self {
        case .day:
            return "Diet"
        case .meal:
            return "Meal Type"
        }
    }
}
