import Foundation

public enum GoalSetType: Int16, Codable, Hashable {
    case diet
    case mealType
    
    public var description: String {
        switch self {
        case .diet:
            return "Diet"
        case .mealType:
            return "Meal Type"
        }
    }
}
