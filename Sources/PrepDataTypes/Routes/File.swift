import Foundation

public enum MealItemRoute: Hashable {
    case summary(Food)
    case amount(Food)
    case meal(Food)
}

