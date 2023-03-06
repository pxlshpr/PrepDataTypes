import Foundation

public struct UserOptions: Hashable, Codable {

    public struct Units: Hashable, Codable {
        public var energy: EnergyUnit
        public var weight: WeightUnit
        public var height: HeightUnit
        public var volume: UserExplicitVolumeUnits
        
        public static var defaultUnits: Units {
            Units(
                energy: .kcal,
                weight: .kg,
                height: .cm,
                volume: .defaultUnits
            )
        }
    }
    
    
    public struct Log: Hashable, Codable {
        public var showingBadgesForFoods: Bool = true
        public var showingDetails: Bool = false
        public var showingEmojis: Bool = true
        public var secondaryButton: SecondaryLogButton = .scan
    }
    
    public struct Ingredients: Hashable, Codable {
        public var showingDetails: Bool = true
        public var showingBadges: Bool = true
        public var showingEmojis: Bool = true
    }
    
    public struct Metrics: Hashable, Codable {
        public var page: MetricsPage = .overview
    }
    
    public struct Charts: Hashable, Codable {
        public var period: ChartPeriod = .day
        public var showingMacrosForEnergy: Bool = true
    }
    
    public struct Portion: Hashable, Codable {
        public var page: PortionPage = .nutrients
        public var showingLegend: Bool = true
        public var showingRDA: Bool = true
        public var usingDietGoalsInsteadOfRDA: Bool = true
    }
    
    public struct FoodList: Hashable, Codable {
        public var sortOrder: FoodSortOrder = .name
        public var filter: FoodFilter = .all
    }
    
    public var units: Units
    public var log: Log
    public var ingredients: Ingredients
    public var metrics: Metrics
    public var charts: Charts
    public var portion: Portion
    public var foodList: FoodList
    
    public static var defaultOptions: UserOptions {
        UserOptions(
            units: .defaultUnits,
            log: Log(),
            ingredients: Ingredients(),
            metrics: Metrics(),
            charts: Charts(),
            portion: Portion(),
            foodList: FoodList()
        )
    }
}
