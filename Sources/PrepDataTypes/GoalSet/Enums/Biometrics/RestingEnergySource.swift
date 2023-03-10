import Foundation

public enum RestingEnergySource: Int16, Codable, CaseIterable {
    case health = 1
    case formula
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .health:
            return "Health App"
        case .formula:
            return "Calculate"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .health:
            return "Sync with Health App"
        case .formula:
            return "Calculate"
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
        case .userEntered:
            return "keyboard"
        }
    }
}
