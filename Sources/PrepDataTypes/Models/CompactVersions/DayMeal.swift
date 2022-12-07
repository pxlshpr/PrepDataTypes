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
        id: UUID = UUID(),
        name: String,
        time: Double,
        markedAsEatenAt: Double? = nil,
        goalSet: GoalSet? = nil,
        foodItems: [MealFoodItem] = []
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

//MARK: Move these into their own

public enum MealsDiaryAction {
    case addMeal(Date?)
    case editMeal(DayMeal)
    case addFood(DayMeal)
    case editFoodItem(MealFoodItem, DayMeal)
    case toggleCompletion(MealFoodItem, DayMeal)
}

public enum HomeViewFullScreenSheet: String, Identifiable {
    case foodForm
    case search
    case mealFoodItemEdit
    
    public var id: String {
        rawValue
    }
}

public enum HomeViewSheet: String, Identifiable {
    case barcodeScanner
    case foodLabelCamera
    case addMeal
    case mealEdit
    case settings
    case useTemplate
    case myFoods
    case diets
    case mealTypes
    case bodyProfileForm
    case daySummary
    
    public var id: String {
        rawValue
    }
}

public struct FastingTimerState {
    public var lastMealTime: Date
    public var nextMealTime: Date?
    
    public init(lastMealTime: Date, nextMealTime: Date? = nil) {
        self.lastMealTime = lastMealTime
        self.nextMealTime = nextMealTime
    }
}
