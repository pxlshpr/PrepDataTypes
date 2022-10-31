public struct GoalMicro: Codable, Hashable {
    public let nutrientType: NutrientType
    public let micro: GoalMicroType
    public let value: Double
    public let nutrientUnit: NutrientUnit
}
