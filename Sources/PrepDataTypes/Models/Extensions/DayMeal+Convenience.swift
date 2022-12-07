import Foundation

public extension DayMeal {
    
    var isCompleted: Bool {
        foodItems.allSatisfy({ $0.isCompleted })
        //TODO: Do we need this per meal?
//        markedAsEatenAt != nil && markedAsEatenAt != 0
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
    
    var energyValueInKcal: Double {
        foodItems.reduce(0) {
            $0 + $1.scaledValueForEnergyInKcal
        }
    }
    
    func scaledValueForMacro(_ macro: Macro) -> Double {
        foodItems.reduce(0) {
            $0 + $1.scaledValueForMacro(macro)
        }
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
