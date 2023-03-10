import Foundation

public enum HealthPeriodOption: Int16, Codable, CaseIterable {
    case previousDay = 1
    case average
    
    public var pickerDescription: String {
        switch self {
        case .previousDay:
            return "Latest"
        case .average:
            return "Daily Average"
        }
    }
    public var menuDescription: String {
        switch self {
        case .previousDay:
            return "latest value"
        case .average:
            return "daily average of"
        }
    }
    
    public var energyPrefix: String {
        switch self {
        case .previousDay:
            return "latest"
        case .average:
            return "currently"
        }
    }
}
