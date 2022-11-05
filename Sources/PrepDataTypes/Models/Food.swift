import Foundation

public struct Food: Identifiable, Hashable, Codable {
    public let id: UUID
    public let type: FoodType
    public let name: String
    public let emoji: String
    public let detail: String?
    public let brand: String?
    public let numberOfTimesConsumedGlobally: Int
    public let numberOfTimesConsumed: Int
    public let lastUsedAt: Double?
    public let firstUsedAt: Double?
    public let info: FoodInfo

    /// `UserFood` specific
    public let publishStatus: UserFoodPublishStatus?
    public var jsonSyncStatus: SyncStatus
    public let childrenFoods: [Food]? //TODO: Use compact version here if we'll get cyclical errors

    /// `PresetFood` specific
    public let dataset: FoodDataset?

    public let barcodes: [Barcode]?
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
}

