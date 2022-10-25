import Foundation

public enum UserFoodStatus: Int16, Codable {
    case notPublished = 1
    case pendingReview
    case verified
    case rejected
}
