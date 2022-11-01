import Foundation

public struct User: Identifiable, Hashable, Codable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var preferredEnergyUnit: EnergyUnit
    public var prefersMetricUnits: Bool
    public var explicitVolumeUnits: UserExplicitVolumeUnits
    public var bodyMeasurements: BodyMeasurements?
    
    public var updatedAt: Double
    public var syncStatus: SyncStatus

    public init(id: UUID, cloudKitId: String?, preferredEnergyUnit: EnergyUnit, prefersMetricUnits: Bool, explicitVolumeUnits: UserExplicitVolumeUnits, bodyMeasurements: BodyMeasurements?, syncStatus: SyncStatus, updatedAt: Double) {
        self.id = id
        self.cloudKitId = cloudKitId
        self.preferredEnergyUnit = preferredEnergyUnit
        self.prefersMetricUnits = prefersMetricUnits
        self.explicitVolumeUnits = explicitVolumeUnits
        self.bodyMeasurements = bodyMeasurements
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
    }
}

public extension User {
    init(cloudKitId: String) {
        self.init(
            id: UUID(),
            cloudKitId: cloudKitId,
            preferredEnergyUnit: .kcal,
            prefersMetricUnits: true,
            explicitVolumeUnits: .defaultUnits,
            bodyMeasurements: .empty,
            syncStatus: .notSynced,
            updatedAt: Date().timeIntervalSince1970
        )
    }
}
