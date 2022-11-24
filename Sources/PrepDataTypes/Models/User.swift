import Foundation

public struct User: Identifiable, Hashable, Codable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var units: UserUnits
    public var bodyProfile: BodyProfile?
    public var bodyProfileUpdatedAt: Double?

    public var updatedAt: Double
    public var syncStatus: SyncStatus

    public init(
        id: UUID,
        cloudKitId: String?,
        units: UserUnits,
        bodyProfile: BodyProfile? = nil,
        bodyProfileUpdatedAt: Double? = nil,
        syncStatus: SyncStatus,
        updatedAt: Double
    ) {
        self.id = id
        self.cloudKitId = cloudKitId
        self.units = units
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
            units: UserUnits.standard,
            bodyProfile: nil,
            bodyProfileUpdatedAt: nil,
            syncStatus: .notSynced,
            updatedAt: Date().timeIntervalSince1970
        )
    }
}
