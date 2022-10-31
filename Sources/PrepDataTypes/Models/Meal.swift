import Foundation

public struct Meal: Identifiable, Hashable {
    public let id: UUID
    
    public var day: Day
    public var name: String
    public var time: Date
    public var markedAsEatenAt: Date?

    public var foods: [Food]

    public var syncStatus: SyncStatus
    public var updatedAt: Date
    public var deletedAt: Date?
}
