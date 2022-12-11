import Foundation

public enum FastingTimerCountdownType: Int16, Codable {
    case nextMeal
    case nextMilestone
    case none
}

public struct FastingTimerState: Codable, Hashable {
    public var lastMealTime: Date
    public var nextMealName: String?
    public var nextMealTime: Date?
    
    public var countdownType: FastingTimerCountdownType

    public init(
        lastMealTime: Date,
        nextMealName: String? = nil,
        nextMealTime: Date?,
        countdownType: FastingTimerCountdownType = .nextMeal
    ) {
        self.lastMealTime = lastMealTime
        self.nextMealName = nextMealName
        self.nextMealTime = nextMealTime
        self.countdownType = countdownType
    }

    public init(
        lastMealTime: Date,
        nextMeal: DayMeal? = nil,
        countdownType: FastingTimerCountdownType = .nextMeal
    ) {
        self.lastMealTime = lastMealTime
        self.nextMealName = nextMeal?.name
        self.nextMealTime = nextMeal?.timeDate
        self.countdownType = countdownType
    }
}

extension FastingMilestone {
    func time(from startTime: Date) -> Date {
        Date(timeIntervalSince1970: startTime.timeIntervalSince1970 + startTimeInterval)
    }
}

public struct FastingActivityNextUp {
    public let emoji: String
    
    public let time: Date?
    public let name: String?
    public let progress: Double

    public let startTime: Date
    
    public var shouldShowDays: Bool {
        guard let time else { return true }
        return time.numberOfDaysFrom(startTime) > 0
    }
}

public extension FastingTimerState {
    
    var lastMilestoneTime: Date {
        lastMilestone.time(from: lastMealTime)
    }
    
    var haveNextUp: Bool {
        nextUp != nil
    }
    var height: CGFloat {
        haveNextUp ? 140 : 70
    }
    
    var elapsedHoursFromLastMilestone: Int {
        Int(elapsedFromLastMilestone / 3600)
    }
    
    var elapsedHoursFromLastMilestoneIfAfterFirst: Int? {
        guard
            lastMilestone != .anabolic
        else { return nil }
        return elapsedHoursFromLastMilestone
    }
    
    var nextUp: FastingActivityNextUp {
        if let nextMealName, let nextMealTime, let progressToNextMeal {
            return .init(
                emoji: "🍽",
                time: nextMealTime,
                name: nextMealName,
                progress: progressToNextMeal,
                startTime: lastMealTime
            )
        } else if let nextMilestone, let nextMilestoneTime, let progressToNextMilestone {
            return .init(
                emoji: nextMilestone.emoji,
                time: nextMilestoneTime,
                name: nextMilestone.name,
                progress: progressToNextMilestone,
                startTime: lastMealTime
            )
        } else {
            return .init(
                emoji: "🌈",
                time: nil,
                name: nil,
                progress: 1.0,
                startTime: lastMealTime
            )
        }
    }

    var nextUp_legacy: (String, String, Date, Double, Bool, Date)? {
        if let nextMealName, let nextMealTime, let progressToNextMeal {
            return (
                "🍽",
                nextMealName,
                nextMealTime,
                progressToNextMeal,
                nextMealTime.numberOfDaysFrom(lastMealTime) > 0,
                lastMealTime
            )
        }
        if let nextMilestone, let nextMilestoneTime, let progressToNextMilestone {
            return (
                nextMilestone.emoji,
                nextMilestone.name,
                nextMilestoneTime,
                progressToNextMilestone,
                nextMilestoneTime.numberOfDaysFrom(lastMealTime) > 0,
                lastMealTime
            )
        } else {
            return (
                "🌈",
                "No more",
                Date(),
                1.0,
                true,
                lastMealTime
            )
        }
    }
    
    var nextMealMilestoneEmoji: String? {
        guard let timeIntervalFromLastMealToNextMeal else { return nil }
        return FastingMilestone(timeInterval: timeIntervalFromLastMealToNextMeal).emoji
    }
    
    var nextMilestoneTime: Date? {
        nextMilestone?.time(from: lastMealTime)
    }
    
    var nextMilestone: FastingMilestone? {
        lastMilestone.nextMilestone
    }
    
    var elapsed: TimeInterval {
        Date().timeIntervalSince(lastMealTime)
    }
    
    var numberOfHours: Int {
        Int(Date().timeIntervalSince(lastMealTime) / 3600.0)
    }
    
    var numberOfHoursString: String {
        "\(numberOfHours)"
    }
    
    var emoji: String {
        lastMilestone.emoji
    }
    
    //TODO: Add options to
    /// [ ] Show progress to next meal when available (otherwises uses stage)
    /// [ ] Show fasting stage icon or number of hours
    var progress: Double {
        progressToNextMeal ?? progressToNextMilestone ?? 1.0
    }

    var lastMilestone: FastingMilestone {
        FastingMilestone(hours: numberOfHours)
    }
    
    var elapsedFromLastMilestone: TimeInterval {
        elapsed - lastMilestone.startTimeInterval
    }
    
    var timeIntervalFromLastMealToNextMeal: TimeInterval? {
        guard let nextMealTime else { return nil }
        return nextMealTime.timeIntervalSince(lastMealTime)
    }

    var progressToNextMeal: Double? {
        guard let timeIntervalFromLastMealToNextMeal else { return nil }
        return elapsed / timeIntervalFromLastMealToNextMeal
    }
    
    var progressToNextMilestone: Double? {
//        guard let timeIntervalToNextMilestone = lastMilestone.timeIntervalToNextMilestone else { return nil }
//        return elapsedFromLastMilestone / timeIntervalToNextMilestone
        
        guard let nextMilestone = nextMilestone else { return nil }
        let timeInterval = nextMilestone.startTimeInterval
        return elapsed / timeInterval
    }
}
