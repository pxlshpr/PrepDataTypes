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
}
