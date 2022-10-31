import Foundation

public struct QuickMealItem: Identifiable, Hashable {
    public let id: UUID
    
    public var meal: Meal
    public var name: String
    public var nutrients: QuickMealNutrients
    public var imageIds: [UUID]?

    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
