import Foundation

public struct Meal: Identifiable, Hashable, Codable {
    public let id: UUID
    
    public var day: Day
    public var name: String
    public var time: Date
    public var markedAsEatenAt: Date?

    public var foodItems: [FoodItem]

    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
