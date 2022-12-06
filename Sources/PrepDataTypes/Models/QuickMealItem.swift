import Foundation

public struct QuickMealItem: Identifiable, Hashable, Codable {
    public let id: UUID
    
    public var meal: Meal
    public var name: String
    public var nutrients: QuickMealNutrients
    public var imageIds: [UUID]?

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
}

public extension QuickMealItem {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }
}
