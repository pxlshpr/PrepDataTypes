import Foundation

public extension Date {
    var calendarDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd"
        return dateFormatter.string(from: self).lowercased()
    }
    
    init?(from calendarDayString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy_MM_dd"
        guard let date = dateFormatter.date(from: calendarDayString) else {
            return nil
        }
        self = date
    }
}
