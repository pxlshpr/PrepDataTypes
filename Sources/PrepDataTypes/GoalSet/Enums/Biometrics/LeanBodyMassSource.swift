import Foundation

public enum LeanBodyMassSource: Int16, Codable, CaseIterable {
    case health = 1
    case equation
    case fatPercentage
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .equation:
            return "Use an equation"
        case .health:
            return "Sync with Health App"
        case .fatPercentage:
            return "Use Fat Percentage"
        case .userEntered:
            return "Type it in"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .health:
            return "heart.fill"
        case .equation:
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
        case .equation:
            return "Equation"
        case .health:
            return "Health App"
        case .fatPercentage:
//            return "Fat percentage"
            return "Fat Percentage"
        case .userEntered:
            return "Type it in"
        }
    }
    
    public var usesWeight: Bool {
        switch self {
        case .equation, .fatPercentage:
            return true
        default:
            return false
        }
    }
}
