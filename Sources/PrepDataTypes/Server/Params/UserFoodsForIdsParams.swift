import Foundation

public struct UserFoodsForIdsParams: Codable {
    public let userFoodIds: [UUID]
    
    public init(userFoodIds: [UUID]) {
        self.userFoodIds = userFoodIds
    }
}

