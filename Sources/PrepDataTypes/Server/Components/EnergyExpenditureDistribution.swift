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
