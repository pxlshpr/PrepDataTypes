import Foundation

public struct FoodItem: Identifiable, Hashable {
    public let id: UUID
    public let food: Food
    public let parentFood: Food?
    
    public var meal: Meal?
    public var amount: FoodValue
    public var markedAsEatenAt: Date?
    public var sortPosition: Int
    
    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
