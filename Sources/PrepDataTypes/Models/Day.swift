import Foundation

public struct Day: Identifiable, Hashable {
    public let id: UUID
    public let date: Date
    
    public var goal: Goal?
    public var addEnergyExpendituresToGoal: Bool
    public var goalBonusEnergySplit: GoalBonusEnergySplit?
    public var goalBonusEnergySplitRatio: GoalBonusEnergySplitRatio?
    
    public var syncStatus: SyncStatus
    public var updatedAt: Date
}
