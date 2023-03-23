import Foundation

public enum ActiveEnergySource: Int16, Codable, CaseIterable {
    case health = 1
    case activityLevel
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .health:
            return "Sync with Health App"
        case .activityLevel:
            return "Use Activity level"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .health:
            return "Sync with Health App"
        case .activityLevel:
            return "Choose activity level"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .health:
            return "heart.fill"
        case .activityLevel:
            return "dial.medium.fill"
        case .userEntered:
            return "keyboard"
        }
    }
}
