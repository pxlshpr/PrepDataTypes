import Foundation

/// This is a summarised version of a Meal to be placed inside a `Day` object
/// It is stripped off the relation back to the `Day` so as to not clear a cyclical recursion error,
/// in addition to not having the `syncStatus`, `updatedAt`, `deletedAt` metadata.
/// This is only to be used as a child of a `Day` to be used in the UI.
public struct DayMeal: Identifiable, Hashable, Codable {
    public let id: UUID
    public var name: String
    public var time: Double
    public var markedAsEatenAt: Double?
    public var goalSet: GoalSet?
    public var foodItems: [MealFoodItem]

    public init(
        id: UUID,
        name: String,
        time: Double,
        markedAsEatenAt: Double? = nil,
        goalSet: GoalSet? = nil,
        foodItems: [MealFoodItem]
    ) {
        self.id = id
        self.name = name
        self.time = time
        self.markedAsEatenAt = markedAsEatenAt
        self.goalSet = goalSet
        self.foodItems = foodItems
    }
}

public extension DayMeal {
    init(from meal: Meal) {
        self.init(
            id: meal.id,
            name: meal.name,
            time: meal.time,
            markedAsEatenAt: meal.markedAsEatenAt,
            goalSet: meal.goalSet,
            foodItems: meal.foodItems
        )
    }
}
