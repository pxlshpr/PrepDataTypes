public enum TokenAwardType: Int16, Codable {
    case forPublishingFood = 1
    case forFoodBeingUsedForTheFirstTime
    case forFoodBeingUsed
}

public extension TokenAwardType {
    var tokensToAward: Int {
        switch self {
        case .forPublishingFood:
            return 10
        case .forFoodBeingUsedForTheFirstTime:
            return 10
        case .forFoodBeingUsed:
            return 1
        }
    }
}
