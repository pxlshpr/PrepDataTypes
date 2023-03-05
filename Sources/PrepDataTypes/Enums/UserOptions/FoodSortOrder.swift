import Foundation

public enum FoodSortOrder: Int, CaseIterable, Codable {
    case name
    case dateCreated
    case carbPortion
    case proteinPortion
    case fatPortion
    
    public var description: String {
        switch self {
        case .name:
            return "Name"
        case .dateCreated:
            return "Latest Added"
        case .carbPortion:
            return "Highest Carb"
        case .proteinPortion:
            return "Highest Protein"
        case .fatPortion:
            return "Highest Fat"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .name:
            return "arrow.down"
        case .dateCreated:
            return "clock.badge"
        case .carbPortion:
            return "c.square.fill"
        case .proteinPortion:
            return "p.square.fill"
        case .fatPortion:
            return "f.square.fill"
        }
    }
}
