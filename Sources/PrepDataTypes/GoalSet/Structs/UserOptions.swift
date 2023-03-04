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
    }
    
    public struct Ingredients: Hashable, Codable {
        public var showingDetails: Bool = true
        public var showingBadges: Bool = true
        public var showingEmojis: Bool = true
    }
    
    public struct Metrics: Hashable, Codable {
        public var lastSelectedTab: Int = 1
    }
    
    public struct Nutrition: Hashable, Codable {
        public var chartPeriod: Int = 1
        public var showingMacrosForEnergyReport: Bool = true
    }
    
    public struct Portion: Hashable, Codable {
        public var showingRDA: Bool = true
        public var usingDietGoalsInsteadOfRDA: Bool = true
    }
    
    public var units: Units
    public var log: Log
    public var ingredients: Ingredients
    public var metrics: Metrics
    public var nutrition: Nutrition
    public var portion: Portion
    
    public static var defaultOptions: UserOptions {
        UserOptions(
            units: .defaultUnits,
            log: Log(),
            ingredients: Ingredients(),
            metrics: Metrics(),
            nutrition: Nutrition(),
            portion: Portion()
        )
    }
}
