import Foundation

public enum LogAction {
    case addMeal(Date?)
    case editMeal(DayMeal)
    case addFood(DayMeal)
    case editFoodItem(MealFoodItem, DayMeal)
    case toggleItemCompletion(MealFoodItem)
    case toggleMealCompletion(DayMeal)
}
