import Foundation

public struct Emoji {
    public var id: String
    public var emoji: String
    
    public init(id: String = UUID().uuidString, emoji: String) {
        self.id = id
        self.emoji = emoji
    }
}

extension Emoji: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(emoji)
    }
}

extension Emoji: Equatable {
    public static func ==(lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.id == rhs.id
        && lhs.emoji == rhs.emoji
    }
}
