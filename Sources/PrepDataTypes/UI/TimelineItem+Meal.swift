#if os(iOS)
import Foundation

public extension TimelineItem {
    convenience init(meal: Meal) {
        self.init(
            id: meal.id.uuidString,
            name: meal.name,
            date: Date(timeIntervalSince1970: meal.time),
            emojis: [],
            type: .meal
        )
    }
}

public extension TimelineItem {
    convenience init(dayMeal meal: DayMeal) {
        self.init(
            id: meal.id.uuidString,
            name: meal.name,
            date: Date(timeIntervalSince1970: meal.time),
            emojis: [],
            type: .meal
        )
    }
}
#endif
