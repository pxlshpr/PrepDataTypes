import Foundation

public extension Notification.Name {
    static var dayPagerWillChangeDate: Notification.Name { return .init("dayPagerWillChangeDate") }
    static var weekPagerWillChangeDate: Notification.Name { return .init("weekPagerWillChangeDate") }
    static var weekPagerDidChangeDate: Notification.Name { return .init("weekPagerDidChangeDate") }
    
    static var summaryDetentCollapsed: Notification.Name { return .init("summaryDetentCollapsed") }
    static var summaryDetentExpanded: Notification.Name { return .init("summaryDetentExpanded") }
    static var expandSummaryDetent: Notification.Name { return .init("expandSummaryDetent") }
    static var collapseSummaryDetent: Notification.Name { return .init("collapseSummaryDetent") }

    static var dateDidChange: Notification.Name { return .init("dateDidChange") }
    static var diaryWillChangeDate: Notification.Name { return .init("diaryWillChangeDate") }
    static var didPickDateOnDayView: Notification.Name { return .init("didPickDateOnDayView") }
    static var summaryViewTypeChanged: Notification.Name { return .init("summaryViewTypeChanged") }
    
    static var foodItemCompletionDidChange: Notification.Name { return .init("foodItemCompletionDidChange") }
    static var didPickDateForMealDuplication: Notification.Name { return .init("didPickDateForMealDuplication") }
    
    static var didTapAddMealButton: Notification.Name { return .init("didTapAddMealButton") }
    
    /// Backend related
    static var didUpdateUser: Notification.Name { return .init("didUpdateUser") }
    static var didAddFood: Notification.Name { return .init("didAddFood") }
    
    static var didUpdateMeals: Notification.Name { return .init("didUpdateMeals") }
    static var didUpdateFoodItems: Notification.Name { return .init("didUpdateFoodItems") }
    static var didUpdateGoalSets: Notification.Name { return .init("didUpdateGoalSets") }
    static var didUpdateFoods: Notification.Name { return .init("didUpdateFoods") }
    static var didUpdateDays: Notification.Name { return .init("didUpdateDays") }
    
    static var shouldRefreshMealsDiaryWindow: Notification.Name { return .init("shouldRefreshMealsDiaryWindow") }
    
    static var didUpdateMealFoodItem: Notification.Name { return .init("didUpdateMealFoodItem") }
    static var didAddFoodItemToMeal: Notification.Name { return .init("didAddFoodItemToMeal") }
    static var didDeleteFoodItemFromMeal: Notification.Name { return .init("didDeleteFoodItemFromMeal") }
    
    static var didAddMeal: Notification.Name { return .init("didAddMeal") }
    static var didUpdateMeal: Notification.Name { return .init("didUpdateMeal") }
    static var didDeleteMeal: Notification.Name { return .init("didDeleteMeal") }
    
    static var didUpdateDayWithBodyProfile: Notification.Name { return .init("didUpdateDayWithBodyProfile") }
    
    static var didCalculateMealMacrosIndicatorWidth: Notification.Name { return .init("didCalculateMealMacrosIndicatorWidth") }

    static var didInvalidateBadgeWidths: Notification.Name { return .init("didInvalidateBadgeWidths") }
    
    static var didBeginDraggingNutrientsSummaryPager: Notification.Name { return .init("didBeginDraggingNutrientsSummaryPager") }
    static var didEndDraggingNutrientsSummaryPager: Notification.Name { return .init("didEndDraggingNutrientsSummaryPager") }

    static var didPickDayMeal: Notification.Name { return .init("didPickDayMeal") }
    
    static var didToggleNutrientReport: Notification.Name { return .init("didToggleNutrientReport") }
}

public extension Notification {
    struct Keys {
        public static let uuid = "id"
        public static let foodItem = "foodItem"
        public static let foodItems = "foodItems"
        public static let goalSet = "goalSet"
        public static let goalSets = "goalSets"
        public static let date = "date"
        public static let summaryViewTypeRawValue = "summaryViewTypeRawValue"
        public static let sender = "sender"
        public static let url = "url"
        public static let meal = "meal"
        public static let dayMeal = "dayMeal"
        public static let meals = "meals"
        public static let food = "food"
        public static let foods = "foods"
        public static let bodyProfile = "bodyProfile"
        
        public static let mealId = "mealId"
        
        public static let bool = "bool"
        public static let nutrientMeterComponent = "nutrientMeterComponent"
    }
}
