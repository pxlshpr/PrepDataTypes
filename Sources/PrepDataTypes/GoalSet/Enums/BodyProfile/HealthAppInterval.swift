import Foundation

public enum HealthAppInterval: Int16, Codable, CaseIterable {
    case day = 1
    case week
    case month
    
    public var description: String {
        switch self {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        }
    }
    
    public var minValue: Int {
        switch self {
        case .day:
            return 2
        default:
            return 1
        }
    }
    public var maxValue: Int {
        switch self {
        case .day:
            return 6
        case .week:
            return 3
        case .month:
            return 12
        }
    }
    
    public var calendarComponent: Calendar.Component {
        switch self {
        case .day:
            return .day
        case .month:
            return .month
        case .week:
            return .weekOfMonth
        }
    }
    
    public func dateRangeOfPast(_ value: Int) -> ClosedRange<Date>? {
        
        let calendar = Calendar(identifier: .gregorian)
        let today = calendar.startOfDay(for: Date())
        let endDate = today

        guard let startDate = calendar.date(
            byAdding: calendarComponent,
            value: -value,
            to: endDate
        ) else {
            return nil
        }

        return startDate.moveDayBy(-1)...endDate.moveDayBy(-1)
    }
}
