import Foundation

public struct FastingTimerState {
    public var lastMealTime: Date
    public var nextMealTime: Date?
    
    public init(lastMealTime: Date, nextMealTime: Date? = nil) {
        self.lastMealTime = lastMealTime
        self.nextMealTime = nextMealTime
    }
}

public extension FastingTimerState {
    
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
        guard let progressToNextMilestone else { return 0 }
        return progressToNextMilestone
    }
    
    var lastMilestone: FastingMilestone {
        FastingMilestone(hours: numberOfHours)
    }
    
    var elapsedFromLastMilestone: TimeInterval {
        elapsed - lastMilestone.startTimeInterval
    }
    
    var progressToNextMilestone: Double? {
        guard let timeIntervalToNextMilestone = lastMilestone.timeIntervalToNextMilestone else {
            return nil
        }
        return elapsedFromLastMilestone / timeIntervalToNextMilestone
    }
}
