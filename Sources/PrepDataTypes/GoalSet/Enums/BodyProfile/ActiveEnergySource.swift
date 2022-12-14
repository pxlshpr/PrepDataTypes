import Foundation

public enum ActiveEnergySource: Int16, Codable, CaseIterable {
    case healthApp = 1
    case activityLevel
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .healthApp:
            return "Health App"
        case .activityLevel:
            return "Activity level"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .healthApp:
            return "Sync with Health App"
        case .activityLevel:
            return "Choose activity level"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .healthApp:
            return "heart.fill"
        case .activityLevel:
            return "dial.medium.fill"
        case .userEntered:
            return "keyboard"
        }
    }
}
