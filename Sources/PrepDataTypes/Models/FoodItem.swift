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
    
    public init(
        id: UUID,
        food: Food,
        parentFood: Food?,
        meal: Meal? = nil,
        amount: FoodValue,
        markedAsEatenAt: Double? = nil,
        sortPosition: Int,
        syncStatus: SyncStatus,
        updatedAt: Double,
        deletedAt: Double? = nil
    ) {
        self.id = id
        self.food = food
        self.parentFood = parentFood
        self.meal = meal
        self.amount = amount
        self.markedAsEatenAt = markedAsEatenAt
        self.sortPosition = sortPosition
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

public extension FoodItem {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }    
}
