import Foundation

public struct FastingActivity: Identifiable, Hashable, Codable {
    public let id: UUID
    public let pushToken: String
    
    public var lastMealAt: Double
    public var nextMealAt: Double?
    public var nextMealName: String?
    public var countdownType: FastingTimerCountdownType
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(
        id: UUID,
        pushToken: String,
        lastMealAt: Double,
        nextMealAt: Double? = nil,
        nextMealName: String? = nil,
        countdownType: FastingTimerCountdownType,
        syncStatus: SyncStatus,
        updatedAt: Double,
        deletedAt: Double? = nil
    ) {
        self.id = id
        self.pushToken = pushToken
        self.lastMealAt = lastMealAt
        self.nextMealAt = nextMealAt
        self.nextMealName = nextMealName
        self.countdownType = countdownType
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
    
    public init(
        fastingTimerState: FastingTimerState,
        pushToken: String
    ) {
        self.init(
            id: UUID(),
            pushToken: pushToken,
            lastMealAt: fastingTimerState.lastMealTime.timeIntervalSince1970,
            nextMealAt: fastingTimerState.nextMealTime?.timeIntervalSince1970,
            nextMealName: fastingTimerState.nextMealName,
            countdownType: fastingTimerState.countdownType,
            syncStatus: .notSynced,
            updatedAt: Date().timeIntervalSince1970,
            deletedAt: nil
        )
    }
}


public extension FastingActivity {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }
}
