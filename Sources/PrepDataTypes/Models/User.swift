import Foundation

public struct User: Identifiable, Hashable, Codable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var options: UserOptions
    public var bodyProfile: BodyProfile?
    public var bodyProfileUpdatedAt: Double?

    public var updatedAt: Double
    public var syncStatus: SyncStatus

    public init(
        id: UUID,
        cloudKitId: String?,
        options: UserOptions,
        bodyProfile: BodyProfile? = nil,
        bodyProfileUpdatedAt: Double? = nil,
        syncStatus: SyncStatus,
        updatedAt: Double
    ) {
        self.id = id
        self.cloudKitId = cloudKitId
        self.options = options
        self.bodyProfile = bodyProfile
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
    }
}

public extension User {
    init(cloudKitId: String) {
        self.init(
            id: UUID(),
            cloudKitId: cloudKitId,
            options: UserOptions.standard,
            bodyProfile: nil,
            bodyProfileUpdatedAt: nil,
            syncStatus: .notSynced,
            updatedAt: Date().timeIntervalSince1970
        )
    }
}
