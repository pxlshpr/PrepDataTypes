import Foundation

public enum RestingEnergySource: Int16, Codable, CaseIterable {
    case health = 1
    case equation
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .health:
            return "Sync with Health App"
        case .equation:
            return "Use an equation"
        case .userEntered:
            return "Type it in"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .health:
            return "Health App"
        case .equation:
            return "Equation"
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
        case .userEntered:
            return "keyboard"
        }
    }
}
