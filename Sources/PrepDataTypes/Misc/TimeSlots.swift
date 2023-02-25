import Foundation


public extension Date {
    func timeSlot(within date: Date) -> Int {
        guard self > date.startOfDay else { return 0 }
        let difference = self.timeIntervalSince1970 - date.startOfDay.timeIntervalSince1970
        let slots = Int(difference / (15 * 60.0))
        guard slots < PrepConstants.numberOfTimeSlotsInADay else { return 0 }
        return slots
    }
    
    func timeForTimeSlot(_ timeSlot: Int) -> Date {
        Date(timeIntervalSince1970: startOfDay.timeIntervalSince1970 + (Double(timeSlot) * 15 * 60))
    }
}


public func nearestAvailableTimeSlot(
    to timeSlot: Int,
    existingTimeSlots: [Int],
    ignoring timeSlotToIgnore: Int? = nil,
    startSearchBackwards: Bool = false,
    searchingBothDirections: Bool = false,
    doNotPassExistingTimeSlots: Bool = false
) -> Int? {
    
    func timeSlotIsAvailable(_ timeSlot: Int) -> Bool {
        if let timeSlotToIgnore {
            return timeSlot != timeSlotToIgnore && !existingTimeSlots.contains(timeSlot)
        } else {
            return !existingTimeSlots.contains(timeSlot)
        }
    }
    
    if startSearchBackwards {
        guard timeSlot >= 0 else { return nil }
        
        /// If we're starting search with timeSlot 0—we won't get a range, so check that by itself
        if timeSlot == 0, timeSlotIsAvailable(0) {
            return 0
        }
        
        /// First search backwards till start till the end
        for t in (0..<timeSlot).reversed() {
            if timeSlotIsAvailable(t) {
                return t
            }
            
            /// End early if the option to not pass any existing timeslots is given
            if doNotPassExistingTimeSlots, existingTimeSlots.contains(timeSlot) {
                return nil
            }
        }
        
        if searchingBothDirections {
            /// If we still haven't find one, go forwards
            for t in timeSlot+1..<PrepConstants.numberOfTimeSlotsInADay {
                if timeSlotIsAvailable(t) {
                    return t
                }
            }
        }
    } else {
        /// First search forwards till the end
        for t in timeSlot..<PrepConstants.numberOfTimeSlotsInADay {
            if timeSlotIsAvailable(t) {
                return t
            }
            
            /// End early if the option to not pass any existing timeslots is given
            if doNotPassExistingTimeSlots, existingTimeSlots.contains(timeSlot) {
                return nil
            }
        }
        
        if searchingBothDirections {
            /// If we still haven't find one, go backwards
            for t in (0..<timeSlot-1).reversed() {
                if timeSlotIsAvailable(t) {
                    return t
                }
            }
        }
    }
    
    return nil
}

public func nearestAvailableTimeSlot(
    to time: Date,
    within date: Date,
    ignoring timeToIgnoreTimeSlotFor: Date? = nil,
    existingMealTimes: [Date],
    startSearchBackwards: Bool = false,
    searchingBothDirections: Bool = false,
    skippingFirstTimeSlot: Bool = false,
    doNotPassExistingTimeSlots: Bool = false
) -> Int? {
    let timeSlotDelta: Int
    if skippingFirstTimeSlot {
        timeSlotDelta = startSearchBackwards ? -1 : 1
    } else {
        timeSlotDelta = 0
    }
    let timeSlot = time.timeSlot(within: date) + timeSlotDelta
    let timeSlotToIgnore = timeToIgnoreTimeSlotFor?.timeSlot(within: date)
    let existingTimeSlots = existingMealTimes.compactMap {
        $0.timeSlot(within: date)
    }
    
    if startSearchBackwards {
        print("🟨 getting nearestAvailableTimeSlot to \(timeSlot)")
    }

    return nearestAvailableTimeSlot(
        to: timeSlot,
        existingTimeSlots: existingTimeSlots,
        ignoring: timeSlotToIgnore,
        startSearchBackwards: startSearchBackwards,
        searchingBothDirections: searchingBothDirections,
        doNotPassExistingTimeSlots: doNotPassExistingTimeSlots
    )
}
