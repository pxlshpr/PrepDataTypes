import Foundation

//TODO: LogView (move this back to Prep) doesn't have to be here
public enum LogAction {
    case addMeal(Date?)
    case editMeal(DayMeal)
    case addFood(DayMeal)
    case editFoodItem(MealItem, DayMeal)
    case deleteFoodItem(MealItem, DayMeal)
    case toggleItemCompletion(MealItem)
    case toggleMealCompletion(DayMeal)
}
