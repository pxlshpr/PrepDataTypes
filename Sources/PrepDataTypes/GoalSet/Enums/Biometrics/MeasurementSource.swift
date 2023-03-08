import Foundation

public enum MeasurementSource: Int16, Codable, CaseIterable {
    case healthApp = 1
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .healthApp:
            return "Sync with Health App"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .healthApp:
            return "heart.fill"
        case .userEntered:
            return "keyboard"
        }
    }

    public var menuDescription: String {
        switch self {
        case .healthApp:
            return "Health App"
        case .userEntered:
            return "Enter manually"
        }
    }
}
