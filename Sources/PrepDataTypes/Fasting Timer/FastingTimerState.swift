import Foundation

public struct FastingTimerState: Codable, Hashable {
    public var lastMealTime: Date
    public var nextMeal: DayMeal?
    
    public init(lastMealTime: Date, nextMeal: DayMeal? = nil) {
        self.lastMealTime = lastMealTime
        self.nextMeal = nextMeal
    }
}

extension FastingMilestone {
    func time(from startTime: Date) -> Date {
        Date(timeIntervalSince1970: startTime.timeIntervalSince1970 + startTimeInterval)
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

    var nextUp: (String, String, Date, Double)? {
        if let nextMeal, let progressToNextMeal {
            return ("🍽", nextMeal.name, Date(timeIntervalSince1970: nextMeal.time), progressToNextMeal)
        }
        if let nextMilestone, let nextMilestoneTime, let progressToNextMilestone {
            return (nextMilestone.emoji, nextMilestone.name, nextMilestoneTime, progressToNextMilestone)
        }
        return nil
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
        guard let nextMeal else { return nil }
        return nextMeal.timeDate.timeIntervalSince(lastMealTime)
    }

    var progressToNextMeal: Double? {
        guard let timeIntervalFromLastMealToNextMeal else { return nil }
        return elapsed / timeIntervalFromLastMealToNextMeal
    }
    
    var progressToNextMilestone: Double? {
        guard let timeIntervalToNextMilestone = lastMilestone.timeIntervalToNextMilestone else { return nil }
        return elapsedFromLastMilestone / timeIntervalToNextMilestone
    }
}
