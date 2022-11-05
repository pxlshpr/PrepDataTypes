import Foundation

public struct Meal: Identifiable, Hashable, Codable {
    public let id: UUID
    
    public var day: Day
    public var name: String
    public var time: Double
    public var markedAsEatenAt: Double?

    public var foodItems: [FoodItem]

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(
        id: UUID,
        day: Day,
        name: String,
        time: Double,
        markedAsEatenAt: Double? = nil,
        foodItems: [FoodItem],
        syncStatus: SyncStatus,
        updatedAt: Double,
        deletedAt: Double? = nil
    ) {
        self.id = id
        self.day = day
        self.name = name
        self.time = time
        self.markedAsEatenAt = markedAsEatenAt
        self.foodItems = foodItems
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
