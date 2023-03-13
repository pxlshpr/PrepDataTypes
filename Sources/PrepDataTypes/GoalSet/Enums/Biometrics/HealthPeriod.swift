import Foundation

public enum HealthPeriod: Int16, Codable, CaseIterable {
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
    
    public func dateRangeOfPast(_ value: Int, to date: Date = Date()) -> ClosedRange<Date>? {
        
        let calendar = Calendar(identifier: .gregorian)
        let startOfDay = calendar.startOfDay(for: date)
        let endDate = startOfDay

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


//MARK: - Health Interval

public struct HealthInterval: Hashable, Codable, Equatable {
    public var value: Int
    public var period: HealthPeriod
    public var timestamp: Double?
    
    public func equalsWithoutTimestamp(_ other: HealthInterval) -> Bool {
        value == other.value && period == other.period
    }
    
    public init(_ value: Int, _ period: HealthPeriod, timestamp: Double? = nil) {
        self.value = value
        self.period = period
        self.timestamp = timestamp
    }
    
    public var greaterIntervals: [HealthInterval] {
        let all = Self.allIntervals
        guard let index = all.firstIndex(where: { $0.value == self.value && $0.period == self.period }),
              index + 1 < all.count
        else { return [] }
        return Array(all[index+1..<all.count])
    }
    
    static var allIntervals: [HealthInterval] {
        /// Prefill `(1, .day)` because 1 isn't included in the possible values for `.day`
        var intervals: [HealthInterval] = [.init(1, .day)]
        for period in HealthPeriod.allCases {
            for value in period.minValue...period.maxValue {
                intervals.append(.init(value, period))
            }
        }
        return intervals
    }
    
    public var periodType: HealthPeriodType {
        value == 1 && period == .day
        ? .latest
        : .average
    }
    
    mutating public func correctIfNeeded() {
        if value < period.minValue {
            value = period.minValue
        }
        if value > period.maxValue {
            value = period.maxValue
        }
    }
    
    public var dateRange: ClosedRange<Date>? {
        period.dateRangeOfPast(value)
    }
    
    public var isLatest: Bool {
        value == 1 && period == .day
    }
}

extension HealthInterval: CustomStringConvertible {
    public var description: String {
        "\(value) \(period.description)"
    }
}
