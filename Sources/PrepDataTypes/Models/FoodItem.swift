import Foundation

public struct FoodItem: Identifiable, Hashable, Codable {
    public let id: UUID
    public let food: Food
    public let parentFood: Food?
    
    public var meal: Meal?
    public var amount: FoodValue
    public var markedAsEatenAt: Double?
    public var sortPosition: Int
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
}
