import Foundation

/// This is a summarised version of a `FoodItem` to be placed inside a `Meal` object
/// It is stripped off the relation back to the `Meal` so as to not clear a cyclical recursion error,
/// in addition to not having the `syncStatus`, `updatedAt`, `deletedAt` metadata.
/// This is only to be used as a child of a `Meal` to be used in the UI.
public struct MealFoodItem: Identifiable, Hashable, Codable {
    public let id: UUID
    public let food: Food
    public var amount: FoodValue
    public var markedAsEatenAt: Double?
    public var sortPosition: Int

//    public let parentFood: Food?
//    public var meal: Meal?

    public init(id: UUID = UUID(), food: Food, amount: FoodValue, markedAsEatenAt: Double? = nil, sortPosition: Int = 0) {
        self.id = id
        self.food = food
        self.amount = amount
        self.markedAsEatenAt = markedAsEatenAt
        self.sortPosition = sortPosition
    }
}

public extension MealFoodItem {
    init(from foodItem: FoodItem) {
        self.init(
            id: foodItem.id,
            food: foodItem.food,
            amount: foodItem.amount,
            markedAsEatenAt: foodItem.markedAsEatenAt,
            sortPosition: foodItem.sortPosition
        )
    }
}
