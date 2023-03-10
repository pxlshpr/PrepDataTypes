import Foundation

public enum MeasurementSource: Int16, Codable, CaseIterable {
    case health = 1
    case userEntered
    
    public var pickerDescription: String {
        switch self {
        case .health:
            return "Sync with Health App"
        case .userEntered:
            return "Enter manually"
        }
    }
    
    public var systemImage: String {
        switch self {
        case .health:
            return "heart.fill"
        case .userEntered:
            return "keyboard"
        }
    }

    public var menuDescription: String {
        switch self {
        case .health:
            return "Health App"
        case .userEntered:
            return "Enter manually"
        }
    }
}
