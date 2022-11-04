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
        foodItems.reduce(0) { $0 + $1.energyAmount }
    }
    
#if os(iOS) || os(macOS)
    var timeString: String {
        Date(timeIntervalSince1970: time).formatted(date: .omitted, time: .shortened).lowercased()
    }
#endif
    
//    var timeDate: Date {
//        get { Date(timeIntervalSince1970: TimeInterval(time)) }
//        set { time = Int64(newValue.timeIntervalSince1970) }
//    }

}

