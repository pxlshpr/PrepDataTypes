import Foundation

public struct Food: Identifiable, Hashable, Codable {
    public let id: UUID
    public let type: FoodType
    public let dataset: FoodDataset?
    public let name: String
    public let emoji: String
    public let detail: String?
    public let brand: String?
    public let publishStatus: UserFoodPublishStatus
    public let numberOfTimesConsumedGlobally: Int
    public let numberOfTimesConsumed: Int
    public let lastUsedAt: Date?
    public let firstUsedAt: Date?
    public let info: UserFoodInfo
    
    public let childrenFoods: [Food]?
    
    public var syncStatus: SyncStatus
    public var jsonSyncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}

