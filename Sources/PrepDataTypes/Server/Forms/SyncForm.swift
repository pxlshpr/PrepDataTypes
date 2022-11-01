import Foundation

public struct SyncForm: Codable {
    public let updates: Updates?
    public let deletions: Deletions?
    public let versionTimestamp: Double
    
    public init(
        updates: Updates? = nil,
        deletions: Deletions? = nil,
        versionTimestamp: Double
    ) {
        self.updates = updates
        self.deletions = deletions
        self.versionTimestamp = versionTimestamp
    }
}

extension SyncForm {
    public struct Updates: Codable {
        public let user: User?
        public let barcodes: [Barcode]?
        public let days: [Day]?
        public let energyExpenditures: [EnergyExpenditure]?
        public let foods: [Food]?
        public let foodItems: [FoodItem]?
        public let goals: [Goal]?
        public let meals: [Meal]?
        public let quickMealItems: [QuickMealItem]?
        
        public init(
            user: User? = nil,
            barcodes: [Barcode]? = nil,
            days: [Day]? = nil,
            energyExpenditures: [EnergyExpenditure]? = nil,
            foods: [Food]? = nil,
            foodItems: [FoodItem]? = nil,
            goals: [Goal]? = nil,
            meals: [Meal]? = nil,
            quickMealItems: [QuickMealItem]? = nil
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
        }
    }
}

extension SyncForm {
    public struct Deletions: Codable {
        public let barcodeIds: [UUID]?
        public let dayIds: [UUID]?
        public let energyExpenditureIds: [UUID]?
        public let foodIds: [UUID]?
        public let foodItemIds: [UUID]?
        public let goalIds: [UUID]?
        public let mealIds: [UUID]?
        public let quickMealItemIds: [UUID]?
        
        public init(
            barcodeIds: [UUID]? = nil,
            dayIds: [UUID]? = nil,
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
