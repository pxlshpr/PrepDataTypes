import Foundation

public struct Meal: Identifiable, Hashable, Codable {
    public let id: UUID
    
    public var day: Day
    public var name: String
    public var time: Double
    public var markedAsEatenAt: Double?
    
    public var goalSet: GoalSet?
    public var goalWorkoutMinutes: Int?

    public var badgeWidth: Double?
    
    public var foodItems: [MealFoodItem]

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(
        id: UUID,
        day: Day,
        name: String,
        time: Double,
        markedAsEatenAt: Double? = nil,
        goalSet: GoalSet? = nil,
        goalWorkoutMinutes: Int? = nil,
        badgeWidth: Double = 0,
        foodItems: [MealFoodItem],
        syncStatus: SyncStatus,
        updatedAt: Double,
        deletedAt: Double? = nil
    ) {
        self.id = id
        self.day = day
        self.name = name
        self.time = time
        self.markedAsEatenAt = markedAsEatenAt
        self.goalSet = goalSet
        self.goalWorkoutMinutes = goalWorkoutMinutes
        self.badgeWidth = badgeWidth
        self.foodItems = foodItems
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

public extension Meal {
    var nextSortPosition: Int {
        let sorted = foodItems.sorted(by: { $0.sortPosition > $1.sortPosition })
        guard let first = sorted.first else { return 1 }
        return first.sortPosition + 1
    }
}

public extension Meal {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }
}
