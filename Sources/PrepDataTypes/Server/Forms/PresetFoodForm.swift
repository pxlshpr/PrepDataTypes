import Foundation

public struct PresetFoodForm: Codable {
    public let id: String
    public let food: Food
    
    public init(id: String, food: Food) {
        self.id = id
        self.food = food
    }
}
