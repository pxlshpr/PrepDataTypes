import Foundation

public struct User: Identifiable, Hashable, Codable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var options: UserOptions
    public var biometrics: Biometrics
    public var biometricsUpdatedAt: Double?

    public var updatedAt: Double
    public var syncStatus: SyncStatus

    public init(
        id: UUID,
        cloudKitId: String?,
        options: UserOptions,
        biometrics: Biometrics,
        biometricsUpdatedAt: Double? = nil,
        syncStatus: SyncStatus,
        updatedAt: Double
    ) {
        self.id = id
        self.cloudKitId = cloudKitId
        self.options = options
        self.biometrics = biometrics
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
    }
}

public extension User {
    
    init(cloudKitId: String) {
        self.init(
            id: UUID(),
            cloudKitId: cloudKitId,
            options: UserOptions.defaultOptions,
            biometrics: Biometrics(),
            biometricsUpdatedAt: nil,
            syncStatus: .notSynced,
            updatedAt: Date().timeIntervalSince1970
        )
    }
}
