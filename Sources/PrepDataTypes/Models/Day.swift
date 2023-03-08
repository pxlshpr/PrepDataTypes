import Foundation

public struct Day: Identifiable, Hashable, Codable {
    public let id: String
    public let calendarDayString: String
    
    public var goalSet: GoalSet?
    public var biometrics: Biometrics?
    public var markedAsFasted: Bool
    
    public var meals: [DayMeal]
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    
    
    public init(
        id: String,
        calendarDayString: String,
        goalSet: GoalSet? = nil,
        biometrics: Biometrics? = nil,
        markedAsFasted: Bool = false,
        meals: [DayMeal],
        syncStatus: SyncStatus,
        updatedAt: Double
    ) {
        self.id = id
        self.calendarDayString = calendarDayString
        self.goalSet = goalSet
        self.biometrics = biometrics
        self.markedAsFasted = markedAsFasted
        self.meals = meals
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
    }
}
