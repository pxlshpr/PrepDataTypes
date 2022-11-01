import Foundation

public struct User: Identifiable, Hashable {
    public let id: UUID
    public let cloudKitId: String?
    
    public var preferredEnergyUnit: EnergyUnit
    public var prefersMetricUnits: Bool
    public var explicitVolumeUnits: UserExplicitVolumeUnits
    public var bodyMeasurements: BodyMeasurements
    
    public var updatedAt: Date
    
    public init(id: UUID, cloudKitId: String?, preferredEnergyUnit: EnergyUnit, prefersMetricUnits: Bool, explicitVolumeUnits: UserExplicitVolumeUnits, bodyMeasurements: BodyMeasurements, updatedAt: Date) {
        self.id = id
        self.cloudKitId = cloudKitId
        self.preferredEnergyUnit = preferredEnergyUnit
        self.prefersMetricUnits = prefersMetricUnits
        self.explicitVolumeUnits = explicitVolumeUnits
        self.bodyMeasurements = bodyMeasurements
        self.updatedAt = updatedAt
    }
}

