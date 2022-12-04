import Foundation

public extension Date {
    var calendarDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd"
        return dateFormatter.string(from: self).lowercased()
    }
    
    init?(fromCalendarDayString string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy_MM_dd"
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        self = date
    }
}

public extension Date {
    var tdeeFormat: String {
        let dayString: String
        var timeString = shortTime
        if Calendar.current.isDateInToday(self) { dayString = "Today" }
        else if Calendar.current.isDateInYesterday(self) { dayString = "Yesterday" }
        else if Calendar.current.isDateInTomorrow(self) { dayString = "Tomorrow" }
        else {
            let formatter = DateFormatter()
            let sameYear = year == Date().year
            formatter.dateFormat = sameYear ? "d MMM" : "d MMM yy"
            dayString = formatter.string(from: self)
            timeString = ""
        }
        if timeString.isEmpty {
            return dayString
        } else {
            return dayString + ", " + timeString
        }
    }
}

public extension ClosedRange<Date> {
    var description: String {
        "\(lowerBound.calendarDayString) to \(upperBound.calendarDayString)"
    }
    
    var days: [Date] {
        var days: [Date] = []
        let calendar = Calendar(identifier: .gregorian)
        calendar.enumerateDates(
            startingAfter: lowerBound,
            matching: DateComponents(hour: 0, minute: 0, second:0),
            matchingPolicy: .nextTime)
        { (date, _, stop) in
            guard let date = date, date <= upperBound else {
                stop = true
                return
            }
            days.append(date)
        }
        return days
    }
}

//TODO: Revisit this
public extension Date {
    var isInWeeHours: Bool {
        Calendar.current.component(.hour, from: self) <= 5
    }
    
    var atEndOfWeeHours: Date {
        Calendar.current.date(bySettingHour: 5, minute: 55, second: 00, of: self) ?? self
    }
}
