//public struct EnergyExpenditureDistribution: Codable {
//    public let addToCarb: Bool
//    public let addToFat: Bool
//    public let addToProtein: Bool
//    public let distributeUsingGoalRatios: Bool
//}

public enum GoalAddedEnergySplit: Int16, Codable {
    case carb = 1
    case fat
    case protein
    case carbAndFat
    case carbAndProtein
    case fatAndProtein
    case allMacros
}

public enum GoalAddedEnergySplitRatio: Int16, Codable {
    case even
    case goal
}
