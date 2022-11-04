import Foundation

public struct SyncForm: Codable {
    public let updates: Updates?
    public let deletions: Deletions?
    public let userId: UUID
    public let versionTimestamp: Double

    public init(
        updates: Updates? = nil,
        deletions: Deletions? = nil,
        userId: UUID,
        versionTimestamp: Double
    ) {
        self.updates = updates
        self.deletions = deletions
        self.userId = userId
        self.versionTimestamp = versionTimestamp
    }
}


extension SyncForm {
    public struct Updates: Codable {
        
        /// ** Always synced **
        public let user: User?
        public let goals: [Goal]?
        
        /// ** Describes range of sliding window using explicit calendarDayString's of the dates **
        public let daysLowerBound: String?
        public let daysUpperBound: String?
        
        /// ** Sliding window of days and its childrens to keep in sync **
        public let days: [Day]?
        public let meals: [Meal]?
        public let foodItems: [FoodItem]?
        public let quickMealItems: [QuickMealItem]?
        public let energyExpenditures: [EnergyExpenditure]?

        /// ** User Foods owned by the user and previously used foods kept in sync **
        public let foods: [Food]?
        public let barcodes: [Barcode]?
        
        public init(
            user: User? = nil,
            barcodes: [Barcode]? = nil,
            days: [Day]? = nil,
            energyExpenditures: [EnergyExpenditure]? = nil,
            foods: [Food]? = nil,
            foodItems: [FoodItem]? = nil,
            goals: [Goal]? = nil,
            meals: [Meal]? = nil,
            quickMealItems: [QuickMealItem]? = nil,
            daysLowerBound: String? = nil,
            daysUpperbound: String? = nil
        ) {
            self.user = user
            self.barcodes = barcodes
            self.days = days
            self.energyExpenditures = energyExpenditures
            self.foods = foods
            self.foodItems = foodItems
            self.goals = goals
            self.meals = meals
            self.quickMealItems = quickMealItems
            self.daysLowerBound = daysLowerBound
            self.daysUpperBound = daysUpperbound
        }
    }
}

extension SyncForm {
    public struct Deletions: Codable {
        public let barcodeIds: [UUID]?
        public let dayIds: [String]?
        public let energyExpenditureIds: [UUID]?
        public let foodIds: [UUID]?
        public let foodItemIds: [UUID]?
        public let goalIds: [UUID]?
        public let mealIds: [UUID]?
        public let quickMealItemIds: [UUID]?
        
        public init(
            barcodeIds: [UUID]? = nil,
            dayIds: [String]? = nil,
            energyExpenditureIds: [UUID]? = nil,
            foodIds: [UUID]? = nil,
            foodItemIds: [UUID]? = nil,
            goalIds: [UUID]? = nil,
            mealIds: [UUID]? = nil,
            quickMealItemIds: [UUID]? = nil
        ) {
            self.barcodeIds = barcodeIds
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
}

public extension SyncForm.Updates {
    var count: Int {
        var count = 0
        if user != nil { count += 1 }
        if let barcodes { count += barcodes.count }
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
        if let barcodeIds { count += barcodeIds.count }
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
