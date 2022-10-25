import Foundation

public enum FoodVerificationStatus: Int16, Codable {
    case pending = 1
    case verified
    case rejected
}
