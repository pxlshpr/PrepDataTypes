import Foundation

public enum UserFoodPublishStatus: Int16, Codable {
    case hidden = 1
    case pendingReview
    case verified
    case rejected
}
