import Foundation

public struct SyncForm: Codable {
    public let updates: Updates?
    public let deletions: Deletions?
    /// ** Describes range of sliding window ** that user would like updates for—using explicit `calendarDayString`'s of the dates
    public let daysLowerBound: String?
    public let daysUpperBound: String?
    public let userId: UUID
    public let versionTimestamp: Double

    public init(
        updates: Updates? = nil,
        deletions: Deletions? = nil,
        daysLowerBound: String? = nil,
        daysUpperBound: String? = nil,
        userId: UUID,
        versionTimestamp: Double
    ) {
        self.updates = updates
        self.deletions = deletions
        self.daysLowerBound = daysLowerBound
        self.daysUpperBound = daysUpperBound
        self.userId = userId
        self.versionTimestamp = versionTimestamp
    }
}

extension SyncForm {
    public struct Updates: Codable {
        
        /// ** Always synced **
        public let user: User?
        public let goals: [Goal]?
        
        /// ** Sliding window of days and its childrens to keep in sync **
        public let days: [Day]?
        public let meals: [Meal]?
        public let foodItems: [FoodItem]?
        public let quickMealItems: [QuickMealItem]?
        public let energyExpenditures: [EnergyExpenditure]?

        /// ** User Foods owned kept in sync **
        public let foods: [Food]?
        
        public init(
            user: User? = nil,
            days: [Day]? = nil,
            energyExpenditures: [EnergyExpenditure]? = nil,
            foods: [Food]? = nil,
            foodItems: [FoodItem]? = nil,
            goals: [Goal]? = nil,
            meals: [Meal]? = nil,
            quickMealItems: [QuickMealItem]? = nil
        ) {
            self.user = user
            self.days = days
            self.energyExpenditures = energyExpenditures
            self.foods = foods
            self.foodItems = foodItems
            self.goals = goals
            self.meals = meals
            self.quickMealItems = quickMealItems
        }
    }
}

extension SyncForm {
    public struct Deletions: Codable {
        public let dayIds: [String]?
        public let energyExpenditureIds: [UUID]?
        public let foodIds: [UUID]?
        public let foodItemIds: [UUID]?
        public let goalIds: [UUID]?
        public let mealIds: [UUID]?
        public let quickMealItemIds: [UUID]?
        
        public init(
            dayIds: [String]? = nil,
            energyExpenditureIds: [UUID]? = nil,
            foodIds: [UUID]? = nil,
            foodItemIds: [UUID]? = nil,
            goalIds: [UUID]? = nil,
            mealIds: [UUID]? = nil,
            quickMealItemIds: [UUID]? = nil
        ) {
            self.dayIds = dayIds
            self.energyExpenditureIds = energyExpenditureIds
            self.foodIds = foodIds
            self.foodItemIds = foodItemIds
            self.goalIds = goalIds
            self.mealIds = mealIds
            self.quickMealItemIds = quickMealItemIds
        }
    }
}

public extension SyncForm {
    var description: String {
        if isEmpty {
            return "Version: \(Int(versionTimestamp))"
        } else {
            return "Updates: \(updates?.count ?? 0), Deletions: \(deletions?.count ?? 0), Version: \(versionTimestamp)"
        }
    }
    
    var isEmpty: Bool {
        if let updates, updates.count > 0 { return false }
        if let deletions, deletions.count > 0 { return false }
        return true
    }
    
    var requestedDateRange: Range<Date>? {
        guard let daysLowerBound, let daysUpperBound,
              let lowerDate = Date(fromCalendarDayString: daysLowerBound),
              let upperDate = Date(fromCalendarDayString: daysUpperBound),
              lowerDate < upperDate
        else {
            return nil
        }
        return lowerDate..<upperDate.moveDayBy(1)
    }
    
    /// Returns an array of all the `calendarDayString`s representing dates in the range specified by `daysLowerBound...daysUpperBound`
    var requestedCalendarDayStrings: [String] {
        guard let requestedDateRange else { return [] }
        
        let dayDurationInSeconds: TimeInterval = 60*60*24
        var strings: [String] = []
        for date in stride(from: requestedDateRange.lowerBound, to: requestedDateRange.upperBound, by: dayDurationInSeconds) {
            strings.append(date.calendarDayString)
        }
        return strings
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

public extension SyncForm.Updates {
    var count: Int {
        var count = 0
        if user != nil { count += 1 }
        if let days { count += days.count }
        if let energyExpenditures { count += energyExpenditures.count }
        if let foods { count += foods.count }
        if let foodItems { count += foodItems.count }
        if let goals { count += goals.count }
        if let meals { count += meals.count }
        if let quickMealItems { count += quickMealItems.count }
        return count
    }
}

public extension SyncForm.Deletions {
    var count: Int {
        var count = 0
        if let dayIds { count += dayIds.count }
        if let energyExpenditureIds { count += energyExpenditureIds.count }
        if let foodIds { count += foodIds.count }
        if let foodItemIds { count += foodItemIds.count }
        if let goalIds { count += goalIds.count }
        if let mealIds { count += mealIds.count }
        if let quickMealItemIds { count += quickMealItemIds.count }
        return count
    }
}
