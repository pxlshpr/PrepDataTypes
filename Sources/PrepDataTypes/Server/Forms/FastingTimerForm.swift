import Foundation

public struct FastingTimerForm: Codable {

    public let lastMealAt: Double?
    public let nextMealName: String?
    public let nextMealAt: Double?

    public let userId: UUID
    
    /// See `FastingTimerState` for a description of what this does
    public var showRemainingTimeToNextMealWhenAvailable: Bool

    /// This is the `pushToken` returned by a newly created `Activity` that will be used to identify and send updates
    /// to the various devices that the user might have timers running on.
    public let pushToken: String

    public init(
        lastMealAt: Double?,
        nextMealName: String? = nil,
        nextMealAt: Double? = nil,
        showRemainingTimeToNextMealWhenAvailable: Bool = true,
        userId: UUID,
        pushToken: String
    ) {
        self.lastMealAt = lastMealAt
        self.nextMealName = nextMealName
        self.nextMealAt = nextMealAt
        self.showRemainingTimeToNextMealWhenAvailable = showRemainingTimeToNextMealWhenAvailable
        
        self.userId = userId
        self.pushToken = pushToken
    }
    
    public init(
        fastingTimerState state: FastingTimerState? = nil,
        userId: UUID,
        pushToken: String
    ) {
        self.lastMealAt = state?.lastMealTime.timeIntervalSince1970
        self.nextMealName = state?.nextMealName
        self.nextMealAt = state?.nextMealTime?.timeIntervalSince1970
        self.showRemainingTimeToNextMealWhenAvailable = state?.showRemainingTimeToNextMealWhenAvailable ?? false
        
        self.userId = userId
        self.pushToken = pushToken
    }

}
