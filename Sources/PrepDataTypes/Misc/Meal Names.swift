import Foundation

func newMealName(for date: Date = Date()) -> String {
    switch date.h {
    /// Midnight
    case 0...3:
        return "Midnight Snack"
    case 4...9:
        return "Breakfast"
    case 10...11:
        return "Brunch"
    case 12...15:
        return "Lunch"
    case 16...17:
        return "Snack"
    case 18...20:
        return "Dinner"
    case 21...:
        return "Supper"
    default:
        return "Breakfast"
    }
}
