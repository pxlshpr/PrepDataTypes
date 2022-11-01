import Foundation

public struct TokenAwards: Identifiable, Hashable, Codable {
    public let id: UUID
    public let food: Food
    public let awardType: TokenAwardType
    public var tokensAwarded: Int
}
