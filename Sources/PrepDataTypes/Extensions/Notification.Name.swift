import Foundation

public extension Notification.Name {
    static var dayPagerWillChangeDate: Notification.Name { return .init("dayPagerWillChangeDate") }
    static var weekPagerWillChangeDate: Notification.Name { return .init("weekPagerWillChangeDate") }
    static var weekPagerDidChangeDate: Notification.Name { return .init("weekPagerDidChangeDate") }
    
    static var diarySummaryDetentChangedToMedium: Notification.Name { return .init("diarySummaryDetentChangedToMedium") }

    /// To move to PrepDataTypes
    static var dateDidChange: Notification.Name { return .init("dateDidChange") }
    static var diaryWillChangeDate: Notification.Name { return .init("diaryWillChangeDate") }
    static var didPickDateOnDayView: Notification.Name { return .init("didPickDateOnDayView") }
    static var didAddFoodItemToMeal: Notification.Name { return .init("didAddFoodItemToMeal") }
    static var summaryViewTypeChanged: Notification.Name { return .init("summaryViewTypeChanged") }
    
    static var foodItemCompletionDidChange: Notification.Name { return .init("foodItemCompletionDidChange") }
    static var didPickDateForMealDuplication: Notification.Name { return .init("didPickDateForMealDuplication") }
    
    static var didTapAddMealButton: Notification.Name { return .init("didTapAddMealButton") }
    
    /// Backend related
    static var didUpdateUser: Notification.Name { return .init("didUpdateUser") }
    static var didAddMeal: Notification.Name { return .init("didAddMeal") }
    
    static var didUpdateMeals: Notification.Name { return .init("didUpdateMeals") }
}

public extension Notification {
    struct Keys {
        public static let foodItem = "foodItem"
        public static let date = "date"
        public static let summaryViewTypeRawValue = "summaryViewTypeRawValue"
        public static let sender = "sender"
        public static let url = "url"
        public static let meal = "meal"
        public static let meals = "meals"
    }
}
