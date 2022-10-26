import Foundation

public struct FoodSearchResult: Codable, Identifiable, Hashable, Equatable {
    public let id: UUID
    public let name: String
    public let emoji: String
    public let detail: String?
    public let brand: String?
    
    public let carb: Double
    public let fat: Double
    public let protein: Double

    public init(
        id: UUID,
        name: String,
        emoji: String,
        detail: String? = nil,
        brand: String? = nil,
        carb: Double,
        fat: Double,
        protein: Double
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.carb = carb
        self.fat = fat
        self.protein = protein
    }
}
