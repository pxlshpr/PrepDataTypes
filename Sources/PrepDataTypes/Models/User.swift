import Foundation

public struct User: Identifiable, Hashable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var preferredEnergyUnit: EnergyUnit
    public var prefersMetricUnits: Bool
    public var explicitVolumeUnits: UserExplicitVolumeUnits
    public var bodyMeasurements: BodyMeasurements
    
    public var syncStatus: SyncStatus
    public var updatedAt: Date
}

