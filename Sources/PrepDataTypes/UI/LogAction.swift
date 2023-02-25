import Foundation

//TODO: LogView (move this back to Prep) doesn't have to be here
public enum LogAction {
    case addMeal(Date?)
    case editMeal(DayMeal)
    case addFood(DayMeal)
    case editFoodItem(MealFoodItem, DayMeal)
    case deleteFoodItem(MealFoodItem, DayMeal)
    case toggleItemCompletion(MealFoodItem)
    case toggleMealCompletion(DayMeal)
}
