import Foundation

public extension Day {
    var isToday: Bool {
        Date().calendarDayString == calendarDayString
    }
    
    var date: Date {
        guard let date = Date(from: calendarDayString) else {
            print("Error: we couldn't get a date for: \(calendarDayString)")
            return Date()
        }
        
        return date
    }
}
