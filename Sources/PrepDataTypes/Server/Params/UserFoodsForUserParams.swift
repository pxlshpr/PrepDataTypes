import Foundation

public struct UserFoodsForUserParams: Codable {
    public let userId: UUID
    
    public init(userId: UUID) {
        self.userId = userId
    }
}
