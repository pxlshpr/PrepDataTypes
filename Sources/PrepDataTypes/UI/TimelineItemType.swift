import Foundation

public enum TimelineItemType {
    case meal
    case workout
    
    public var image: String {
        switch self {
        case .meal:
            return "fork.knife"
        case .workout:
            return "figure.run"
        }
    }
}
