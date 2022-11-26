import Foundation

public extension DayMeal {
    
    var isCompleted: Bool {
        markedAsEatenAt != nil
        && markedAsEatenAt != 0
    }

    var isNextPlannedMeal: Bool {
        return false
//        guard let day = day,
//              day.isToday,
//              let nextPlannedMeal = day.nextPlannedMeal else {
//            return false
//        }
//        return nextPlannedMeal.id == id
    }
    
    var energyAmount: Double {
//        foodItems.reduce(0) { $0 + $1.energyAmount }
        //TODO: Do energyAmount and fix this
        foodItems.reduce(0) { x, y in  x + 0 }
    }
    
//    var timeDate: Date {
//        get { Date(timeIntervalSince1970: TimeInterval(time)) }
//        set { time = Int64(newValue.timeIntervalSince1970) }
//    }

}


#if os(iOS)
public extension DayMeal {
    var timeString: String {
        Date(timeIntervalSince1970: time).formatted(date: .omitted, time: .shortened).lowercased()
    }
}
#endif
