import Foundation

public enum SecondaryLogButton: Int, CaseIterable, Codable {
    case none = 2
    case scan = 1
    case addMeal = 3
    
    public var description: String {
        switch self {
        case .scan:
            return "Scan Food Label"
        case .none:
            return "None"
        case .addMeal:
            return "Add Meal"
        }
    }
    
    public var systemImage: String? {
        switch self {
        case .scan:
            return "text.viewfinder"
        case .none:
            return nil
        case .addMeal:
            return "calendar.badge.plus"
        }
    }
}
