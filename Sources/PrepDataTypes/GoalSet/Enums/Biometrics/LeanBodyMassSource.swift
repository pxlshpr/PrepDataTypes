import Foundation

public enum LeanBodyMassSource: Int16, Codable, CaseIterable {
    case health = 1
    case formula
    case fatPercentage
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .formula:
            return "Use a formula"
        case .health:
            return "Sync with Health App"
        case .fatPercentage:
            return "Use Fat Percentage"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .health:
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
            return "Formula"
        case .health:
            return "Health App"
        case .fatPercentage:
//            return "Fat percentage"
            return "Fat Percentage"
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
