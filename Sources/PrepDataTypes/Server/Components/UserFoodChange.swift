import Foundation

public struct UserFoodChange: Codable {
    public let type: UserFoodChangeType
    public let newPublishStatus: UserFoodPublishStatus?
    public let timestamp: Double
    public let userId: UUID
    
    public init(type: UserFoodChangeType, newPublishStatus: UserFoodPublishStatus?, timestamp: Double, userId: UUID) {
        self.type = type
        self.newPublishStatus = newPublishStatus
        self.timestamp = timestamp
        self.userId = userId
    }
}
