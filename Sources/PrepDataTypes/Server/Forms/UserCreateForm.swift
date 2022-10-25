import Foundation

public struct UserCreateForm: Codable {
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}
