import Foundation

public enum LeanBodyMassSource: Int16, Codable, CaseIterable {
    case healthApp = 1
    case formula
    case fatPercentage
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .formula:
            return "Calculate"
        case .healthApp:
            return "Sync with Health App"
        case .fatPercentage:
            return "Convert fat %"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .healthApp:
            return "heart.fill"
        case .formula:
            return "function"
        case .fatPercentage:
            return "function"
//            return "percent"
        case .userEntered:
            return "keyboard"
        }
    }

    public var menuDescription: String {
        switch self {
        case .formula:
            return "Calculate"
        case .healthApp:
            return "Health App"
        case .fatPercentage:
//            return "Fat percentage"
            return "Fat %"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var usesWeight: Bool {
        switch self {
        case .formula, .fatPercentage:
            return true
        default:
            return false
        }
    }
}
