import Foundation

public struct SyncForm: Codable {
    public var updates: Updates?
    public let userId: UUID
    public let deviceModelName: String
    public let isInitialSync: Bool
    public let versionTimestamp: Double
    //TODO: Add deviceModel

    /// Legacy
    public let deletions: Deletions?
    /// ** Describes range of sliding window ** that user would like updates for—using explicit `calendarDayString`'s of the dates
    public let daysLowerBound: String?
    public let daysUpperBound: String?

    public init(
        updates: Updates? = nil,
        deletions: Deletions? = nil,
        daysLowerBound: String? = nil,
        daysUpperBound: String? = nil,
        userId: UUID,
        deviceModelName: String,
        isInitialSync: Bool = false,
        versionTimestamp: Double
    ) {
        self.updates = updates
        self.deletions = deletions
        self.daysLowerBound = daysLowerBound
        self.daysUpperBound = daysUpperBound
        self.userId = userId
        self.deviceModelName = deviceModelName
        self.isInitialSync = isInitialSync
        self.versionTimestamp = versionTimestamp
    }
}

extension SyncForm {
    public struct Updates: Codable {
        
        /// ** Always synced **
        public let user: User?
        public var goalSets: [GoalSet]?
        public var fastingActivities: [FastingActivity]?

        /// ** Sliding window of days and its childrens to keep in sync **
        public var days: [Day]?
        public var meals: [Meal]?
        public var quickItems: [QuickItem]?

        /// ** User Foods owned kept in sync **
        public var foods: [Food]?
        
        public var foodItems: [FoodItem]?
//        public let foodUsages: [FoodUsage]?

        public init(
            user: User? = nil,
            days: [Day]? = nil,
            foods: [Food]? = nil,
            foodItems: [FoodItem]? = nil,
            goalSets: [GoalSet]? = nil,
            meals: [Meal]? = nil,
            quickItems: [QuickItem]? = nil,
            fastingActivities: [FastingActivity]? = nil
        ) {
            self.user = user
            self.days = days
            self.foods = foods
            self.foodItems = foodItems
            self.goalSets = goalSets
            self.meals = meals
            self.quickItems = quickItems
            self.fastingActivities = fastingActivities
        }
    }
}

//TODO: Remove this
extension SyncForm {
    public struct Deletions: Codable {
        public let dayIds: [String]?
        public let foodIds: [UUID]?
        public let foodItemIds: [UUID]?
        public let goalSetIds: [UUID]?
        public let mealIds: [UUID]?
        public let quickItemIds: [UUID]?
        
        public init(
            dayIds: [String]? = nil,
            foodIds: [UUID]? = nil,
            foodItemIds: [UUID]? = nil,
            goalSetIds: [UUID]? = nil,
            mealIds: [UUID]? = nil,
            quickItemIds: [UUID]? = nil
        ) {
            self.dayIds = dayIds
            self.foodIds = foodIds
            self.foodItemIds = foodItemIds
            self.goalSetIds = goalSetIds
            self.mealIds = mealIds
            self.quickItemIds = quickItemIds
        }
    }
}

public extension SyncForm {
    
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

//extension Date: Strideable {
//    public func distance(to other: Date) -> TimeInterval {
//        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
//    }
//
//    public func advanced(by n: TimeInterval) -> Date {
//        return self + n
//    }
//}

public extension SyncForm.Updates {
    var count: Int {
        var count = 0
        if user != nil { count += 1 }
        if let days { count += days.count }
        if let foods { count += foods.count }
        if let foodItems { count += foodItems.count }
//        if let foodUsages { count += foodUsages.count }
        if let goalSets { count += goalSets.count }
        if let meals { count += meals.count }
        if let quickItems { count += quickItems.count }
        if let fastingActivities { count += fastingActivities.count }
        
        return count
    }
}

public extension SyncForm.Deletions {
    var count: Int {
        var count = 0
        if let dayIds { count += dayIds.count }
        if let foodIds { count += foodIds.count }
        if let foodItemIds { count += foodItemIds.count }
        if let goalSetIds { count += goalSetIds.count }
        if let mealIds { count += mealIds.count }
        if let quickItemIds { count += quickItemIds.count }
        return count
    }
}


extension SyncForm {
    public mutating func removeRedundantUpdates(from other: SyncForm) {
        if let otherUpdates = other.updates {
            self.updates?.removeRedundantUpdates(from: otherUpdates)
        }
    }
}

extension SyncForm.Updates {
    mutating func removeRedundantUpdates(from other: SyncForm.Updates) {
        if let others = other.goalSets, let goalSets {
            self.goalSets = goalSets.filter({ !$0.isPresent(in: others) })
        }
        if let others = other.fastingActivities, let fastingActivities {
            self.fastingActivities = fastingActivities.filter({ !$0.isPresent(in: others) })
        }
        if let others = other.days, let days {
            self.days = days.filter({ !$0.isPresent(in: others) })
        }
        if let others = other.meals, let meals {
            self.meals = meals.filter({ !$0.isPresent(in: others) })
        }
        if let others = other.foods, let foods {
            self.foods = foods.filter({ !$0.isPresent(in: others) })
        }
        if let others = other.foodItems, let foodItems {
            self.foodItems = foodItems.filter({ !$0.isPresent(in: others) })
        }
    }
}

extension Day {
    func isPresent(in others: [Day]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
    
    func hasSameData(as other: Day) -> Bool {
        other.id == id
        && other.calendarDayString == calendarDayString
        && other.goalSet?.id == goalSet?.id
        && other.bodyProfile == bodyProfile
        && other.markedAsFasted == markedAsFasted
        && other.meals == meals
    }
}

extension Food {
    func isPresent(in others: [Food]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
    
    func hasSameData(as other: Food) -> Bool {
        let hasSameData = other.id == id
        && other.type == type
        && other.name == name
        && other.emoji == emoji
        && other.detail == detail
        && other.brand == brand
        && other.numberOfTimesConsumedGlobally == numberOfTimesConsumedGlobally
        && other.numberOfTimesConsumed == numberOfTimesConsumed
        && other.lastUsedAt == lastUsedAt
        && other.firstUsedAt == firstUsedAt
        && other.info == info
        && other.publishStatus == publishStatus
        && other.dataset == dataset
        && other.barcodes == barcodes
        && other.isDeleted == isDeleted
        
        if let childrenFoods {
            guard let otherChildrenFoods = other.childrenFoods,
                  childrenFoods.count == otherChildrenFoods.count
            else { return false }
            for food in childrenFoods {
                guard otherChildrenFoods.contains(where: { $0.id == food.id })
                else { return false }
            }
        }
        
        return hasSameData
    }
}

public extension FoodItem {
    func isPresent(in others: [FoodItem]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
    
    func hasSameData(as other: FoodItem, andSameSortPosition: Bool = true) -> Bool {
        var hasSameData = other.id == id
        && other.food.id == food.id
        && other.amount == amount
        && other.markedAsEatenAt == markedAsEatenAt
        && other.isDeleted == isDeleted
        && other.parentFood?.id == parentFood?.id
        && other.meal?.id == meal?.id
        
        guard andSameSortPosition else {
            return hasSameData
        }
        return hasSameData && other.sortPosition == sortPosition
    }
}

extension Meal {
    func isPresent(in others: [Meal]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
    
    func hasSameData(as other: Meal) -> Bool {
        other.id == id
        && other.day.hasSameData(as: day)
        && other.name == name
        && other.time == time
        && other.markedAsEatenAt == markedAsEatenAt
        && other.goalWorkoutMinutes == goalWorkoutMinutes
        && other.isDeleted == isDeleted
        && other.foodItems == foodItems
        && other.goalSet?.id == goalSet?.id
    }
}

extension FastingActivity {
    func isPresent(in others: [FastingActivity]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
    
    func hasSameData(as other: FastingActivity) -> Bool {
        other.id == id
        && other.pushToken == pushToken
        && other.lastMealAt == lastMealAt
        && other.nextMealAt == nextMealAt
        && other.nextMealName == nextMealName
        && other.countdownType == countdownType
        && other.isDeleted == isDeleted
    }
}

extension GoalSet {
    func isPresent(in others: [GoalSet]) -> Bool {
        others.contains { hasSameData(as: $0) }
    }
}

