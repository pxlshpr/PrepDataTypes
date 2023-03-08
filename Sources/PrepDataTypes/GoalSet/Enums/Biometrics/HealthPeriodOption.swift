import Foundation

public enum HealthPeriodOption: Int16, Codable, CaseIterable {
    case previousDay = 1
    case average
    
    public var pickerDescription: String {
        switch self {
        case .previousDay:
            return "Previous Day"
        case .average:
            return "Daily Average"
        }
    }
    public var menuDescription: String {
        switch self {
        case .previousDay:
            return "previous day's value"
        case .average:
            return "daily average of"
        }
    }
    
    public var energyPrefix: String {
        switch self {
        case .previousDay:
            return "yesterday"
        case .average:
            return "currently"
        }
    }
}
