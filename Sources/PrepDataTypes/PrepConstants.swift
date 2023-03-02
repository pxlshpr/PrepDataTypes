import Foundation

public struct PrepConstants {
    
    /// Number of slots considering we have slots every 15 minutes and go till 6 am the next day
    public static let numberOfTimeSlotsInADay = 120

    public static let bottomBarHeight: CGFloat = 95
    
    public static let numberOfRecents = 10
    
    /// The window size, which indicates how many more elements we have in each direction.
    /// So a value of 1 would indicate a window of 3 elements, 3 would indicate 7, etc.
    public static let slidingWindowSize = 7
    public static let slidingWindowFullSize = (slidingWindowSize * 2) + 1

    public static let dayIndices = Array(0..<slidingWindowFullSize)
//    public static let dayIndices = [0, 1, 2, 3]
    
    
    public struct DefaultPreferences {
        public static let showingBadgesForFoods = true
        public static let showingFoodDetails = false
        public static let showingFoodEmojis = true

        public static let showingIngredientEmojis = true
        public static let showingIngredientDetails = true
        public static let showingIngredientBadges = true
    }
}

/// Use this for print statements that we can disabled by commenting out one line.
public func cprint(_ string: String) {
//    print(string)
}
