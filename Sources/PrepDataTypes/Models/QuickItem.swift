import Foundation

public struct QuickItem: Identifiable, Hashable, Codable {
    public let id: UUID
    
    public var meal: Meal
    public var name: String
    public var nutrients: QuickNutrients
    public var imageIds: [UUID]?

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
}

public extension QuickItem {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }
}
