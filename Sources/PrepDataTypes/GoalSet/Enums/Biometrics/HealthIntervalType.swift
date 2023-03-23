import Foundation

public enum HealthIntervalType: Int16, Codable, CaseIterable {
    case latest = 1
    case average
    
    public var pickerDescription: String {
        switch self {
        case .latest:
            return "Latest"
        case .average:
            return "Rolling Average"
        }
    }
    public var menuDescription: String {
        switch self {
        case .latest:
            return "latest value"
        case .average:
            return "rolling average of"
        }
    }
    
    public var energyPrefix: String {
        switch self {
        case .latest:
            return "latest"
        case .average:
            return "currently"
        }
    }
}
