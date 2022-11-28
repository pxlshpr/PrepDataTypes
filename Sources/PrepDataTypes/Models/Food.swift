import Foundation

public struct Food: Identifiable, Hashable, Codable {
    public let id: UUID
    public let type: FoodType
    public var name: String
    public let emoji: String
    public var detail: String?
    public var brand: String?
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
    
    public init(id: UUID, type: FoodType, name: String, emoji: String, detail: String?, brand: String?, numberOfTimesConsumedGlobally: Int, numberOfTimesConsumed: Int, lastUsedAt: Double?, firstUsedAt: Double?, info: FoodInfo, publishStatus: UserFoodPublishStatus?, jsonSyncStatus: SyncStatus, childrenFoods: [Food]?, dataset: FoodDataset?, barcodes: [Barcode]?, syncStatus: SyncStatus, updatedAt: Double, deletedAt: Double? = nil) {
        self.id = id
        self.type = type
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.numberOfTimesConsumedGlobally = numberOfTimesConsumedGlobally
        self.numberOfTimesConsumed = numberOfTimesConsumed
        self.lastUsedAt = lastUsedAt
        self.firstUsedAt = firstUsedAt
        self.info = info
        self.publishStatus = publishStatus
        self.jsonSyncStatus = jsonSyncStatus
        self.childrenFoods = childrenFoods
        self.dataset = dataset
        self.barcodes = barcodes
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

