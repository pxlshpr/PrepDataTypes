import Foundation

public struct Day: Identifiable, Hashable, Codable {
    public let id: String
    public let calendarDayString: String
    
    public var goal: Goal?
    public var addEnergyExpendituresToGoal: Bool
    public var goalBonusEnergySplit: GoalBonusEnergySplit?
    public var goalBonusEnergySplitRatio: GoalBonusEnergySplitRatio?
    
    public var energyExpenditures: [EnergyExpenditure]
    public var meals: [Meal]
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    
    public init(id: String, calendarDayString: String, goal: Goal? = nil, addEnergyExpendituresToGoal: Bool, goalBonusEnergySplit: GoalBonusEnergySplit? = nil, goalBonusEnergySplitRatio: GoalBonusEnergySplitRatio? = nil, energyExpenditures: [EnergyExpenditure], meals: [Meal], syncStatus: SyncStatus, updatedAt: Double) {
        self.id = id
        self.calendarDayString = calendarDayString
        self.goal = goal
        self.addEnergyExpendituresToGoal = addEnergyExpendituresToGoal
        self.goalBonusEnergySplit = goalBonusEnergySplit
        self.goalBonusEnergySplitRatio = goalBonusEnergySplitRatio
        self.energyExpenditures = energyExpenditures
        self.meals = meals
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
    }
}
