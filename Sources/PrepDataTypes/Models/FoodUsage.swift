import Foundation

public struct FoodUsage: Identifiable, Hashable, Codable {
    
    public let id: UUID
    public var numberOfTimesConsumed: Int
    public var createdAt: Double
    public var updatedAt: Double
    public var food: Food

    public init(
        id: UUID,
        numberOfTimesConsumed: Int,
        createdAt: Double,
        updatedAt: Double,
        food: Food
    ) {
        self.id = id
        self.numberOfTimesConsumed = numberOfTimesConsumed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.food = food
    }
}
