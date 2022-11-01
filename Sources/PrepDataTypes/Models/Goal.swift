import Foundation

public struct Goal: Identifiable, Hashable, Codable {
    public let id: UUID
    public let isPreset: Bool
    
    public var name: String
    public var isForMeal: Bool
    public var energy: GoalEnergy?
    public var macros: [GoalMacro]?
    public var micros: [GoalMicro]?
    
    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
