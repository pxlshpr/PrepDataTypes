import Foundation

public struct EnergyExpenditure: Identifiable, Hashable, Codable {
    public let id: UUID
    public let healthKitWorkout: HealthKitWorkout?
    
    public var day: Day
    public var name: String
    public var type: EnergyExpenditureType
    public var energyBurned: Double
    public var startedAt: Double?
    public var endedAt: Double?
    public var duration: Int?

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
}
