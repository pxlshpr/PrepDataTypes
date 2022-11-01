import Foundation

public struct Day: Identifiable, Hashable, Codable {
    public let id: UUID
    public let date: Date
    
    public var goal: Goal?
    public var addEnergyExpendituresToGoal: Bool
    public var goalBonusEnergySplit: GoalBonusEnergySplit?
    public var goalBonusEnergySplitRatio: GoalBonusEnergySplitRatio?
    
    public var energyExpenditures: [EnergyExpenditure]
    public var meals: [Meal]
    
    public var syncStatus: SyncStatus
    public var updatedAt: Date
}
