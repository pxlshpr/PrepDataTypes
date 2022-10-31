import Foundation

public struct EnergyExpenditure: Identifiable, Hashable {
    public let id: UUID
    public let healthKitWorkout: HealthKitWorkout?
    
    public var day: Day
    public var name: String
    public var type: EnergyExpenditureType
    public var energyBurned: Double
    public var startedAt: Date?
    public var endedAt: Date?
    public var duration: Int?

    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
