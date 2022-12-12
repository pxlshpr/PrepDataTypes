import Foundation

public struct PresetFoodForm: Codable {
    public let id: String
    public let dataset: FoodDataset
    public let food: Food
    
    public init(id: String, dataset: FoodDataset, food: Food) {
        self.id = id
        self.dataset = dataset
        self.food = food
    }
}
