public struct GoalMicro: Codable {
    public let type: GoalMicroType
    public let micro: GoalMicroType
    public let value: Double
    public let unit: NutrientUnit
}
