import Foundation
import CoreData

public struct Goal: Identifiable {
    public let id: UUID
}

public struct Day: Identifiable {
    public let id: UUID
    public let date: Date
    
    public var goal: Goal?
    public var addEnergyExpendituresToGoal: Bool
    public var goalBonusEnergySplit: GoalBonusEnergySplit?
    public var goalBonusEnergySplitRatio: GoalBonusEnergySplitRatio?
    
    public var syncStatus: SyncStatus
    public var lastSyncedAt: Date?
}
