import Foundation

public enum WorkoutDurationUnit: Int16, Codable, CaseIterable, Identifiable {
    case min = 1
    case hour
    
    public var id: Int16 { rawValue }
    
    public var pickerDescription: String {
        switch self {
        case .min:
            return "minute"
        case .hour:
            return "hour"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .min:
            return "minute"
        case .hour:
            return "hour"
        }
    }

    public var menuDescriptionLong: String {
        switch self {
        case .min:
            return "minute of exercise"
        case .hour:
            return "hour of exercise"
        }
    }

    public var shortDescription: String {
        switch self {
        case .min:
            return "min"
        case .hour:
            return "hr"
        }
    }
}
