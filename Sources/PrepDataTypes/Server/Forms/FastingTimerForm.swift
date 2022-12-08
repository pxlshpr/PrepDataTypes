import Foundation

public struct FastingTimerForm: Codable {

    public var lastMealAt: Double?
    public var nextMealName: String?
    public var nextMealAt: Double?
    public let userId: UUID
    
    public init(lastMealAt: Double?, nextMealName: String? = nil, nextMealAt: Double? = nil, userId: UUID) {
        self.lastMealAt = lastMealAt
        self.nextMealName = nextMealName
        self.nextMealAt = nextMealAt
        self.userId = userId
    }
    
    public init(fastingTimerState state: FastingTimerState? = nil, userId: UUID) {
        self.lastMealAt = state?.lastMealTime.timeIntervalSince1970
        self.nextMealName = state?.nextMealName
        self.nextMealAt = state?.nextMealTime?.timeIntervalSince1970
        self.userId = userId
    }

}
