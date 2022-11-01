import Foundation

public struct TokenRedemptions: Identifiable, Hashable, Codable {
    public let id: UUID
    public var tokensRedeemed: Int
}
