import Foundation
import SwiftSugar

/// This is a summarised version of a `FoodItem` to be placed inside a `Meal` object
/// It is stripped off the relation back to the `Meal` so as to not clear a cyclical recursion error,
/// in addition to not having the `syncStatus`, `updatedAt`, `deletedAt` metadata.
/// This is only to be used as a child of a `Meal` to be used in the UI.
public struct MealFoodItem: Identifiable, Hashable, Codable {
    public var id: UUID
    public var food: Food
    public var amount: FoodValue
    public var markedAsEatenAt: Double?
    public var sortPosition: Int

    public var isSoftDeleted: Bool
    public var macrosIndicatorWidth: CGFloat

//    public let parentFood: Food?
//    public var meal: Meal?

    public init(
        id: UUID = UUID(),
        food: Food,
        amount: FoodValue,
        markedAsEatenAt: Double? = nil,
        sortPosition: Int = 0,
        isSoftDeleted: Bool,
        macrosIndicatorWidth: CGFloat = 0
    ) {
        self.id = id
        self.food = food
        self.amount = amount
        self.markedAsEatenAt = markedAsEatenAt
        self.sortPosition = sortPosition
        self.isSoftDeleted = isSoftDeleted
        self.macrosIndicatorWidth = macrosIndicatorWidth
    }
}

public extension MealFoodItem {
    init(from foodItem: FoodItem) {
        self.init(
            id: foodItem.id,
            food: foodItem.food,
            amount: foodItem.amount,
            markedAsEatenAt: foodItem.markedAsEatenAt,
            sortPosition: foodItem.sortPosition,
            isSoftDeleted: foodItem.deletedAt != nil && foodItem.deletedAt! > 0
        )
    }
}

public extension MealFoodItem {
    var isCompleted: Bool {
        markedAsEatenAt != nil && markedAsEatenAt! > 0
    }
}
