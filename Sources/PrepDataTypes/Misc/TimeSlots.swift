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

public func nextAvailableTimeSlot(
    to timeSlot: Int,
    existingTimeSlots: [Int],
    ignoring timeSlotToIgnore: Int? = nil,
    searchBackwardsIfNotFound: Bool = false,
    doNotPassExistingTimeSlots: Bool = false
) -> Int? {
    
    func timeSlotIsAvailable(_ timeSlot: Int) -> Bool {
        if let timeSlotToIgnore {
            return timeSlot != timeSlotToIgnore && !existingTimeSlots.contains(timeSlot)
        } else {
            return !existingTimeSlots.contains(timeSlot)
        }
    }
    
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
    
    if searchBackwardsIfNotFound {
        /// If we still haven't find one, go backwards
        for t in (0..<timeSlot-1).reversed() {
            if timeSlotIsAvailable(t) {
                return t
            }
        }
    }
    
    return nil
}

public func nextAvailableTimeSlot(
    to time: Date,
    within date: Date,
    ignoring timeToIgnoreTimeSlotFor: Date? = nil,
    existingMealTimes: [Date],
    searchBackwardsIfNotFound: Bool = false,
    skippingFirstTimeSlot: Bool = false,
    doNotPassExistingTimeSlots: Bool = false
) -> Int? {
    let timeSlot = time.timeSlot(within: date) + (skippingFirstTimeSlot ? 1 : 0)
    let timeSlotToIgnore = timeToIgnoreTimeSlotFor?.timeSlot(within: date)
    let existingTimeSlots = existingMealTimes.compactMap {
        $0.timeSlot(within: date)
    }
    return nextAvailableTimeSlot(
        to: timeSlot,
        existingTimeSlots: existingTimeSlots,
        ignoring: timeSlotToIgnore,
        searchBackwardsIfNotFound: searchBackwardsIfNotFound,
        doNotPassExistingTimeSlots: doNotPassExistingTimeSlots
    )
}
