import Foundation

public struct UserFoodChange: Codable {
    public let type: UserFoodChangeType
    public let newStatus: UserFoodStatus?
    public let timestamp: Double
    public let userId: UUID
    
    public init(type: UserFoodChangeType, newStatus: UserFoodStatus?, timestamp: Double, userId: UUID) {
        self.type = type
        self.newStatus = newStatus
        self.timestamp = timestamp
        self.userId = userId
    }
}
