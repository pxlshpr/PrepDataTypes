import Foundation

public enum FoodType: Int16, Codable, CaseIterable {
    case food = 1
    case recipe
    case plate
    
    public var systemImage: String {
        switch self {
        case .food:
            return "carrot"
        case .plate:
            return "fork.knife"
        case .recipe:
            return "frying.pan"
        }
    }
}

extension FoodType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .food:
            return "Food"
        case .plate:
            return "Plate"
        case .recipe:
            return "Recipe"
        }
    }
}
