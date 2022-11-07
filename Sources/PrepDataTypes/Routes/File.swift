import Foundation

public enum MealItemRoute: Hashable {
    case summary(Food)
    case amount(Food, FoodValue)
    case meal(Food, Meal?)
}

