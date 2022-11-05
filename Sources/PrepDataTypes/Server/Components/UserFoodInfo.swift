import Foundation

public struct UserFoodInfo: Codable, Hashable {
    public var amount: FoodValue
    public var serving: FoodValue?
    public var nutrients: FoodNutrients
    public var sizes: [FoodSize]
    public var density: FoodDensity?
    
    public var linkUrl: String?
    public var prefilledUrl: String?
    public var imageIds: [UUID]?
    public var barcodes: [FoodBarcode]
    public var spawnedUserFoodId: UUID?
    public var spawnedPresetFoodId: UUID?
    
    public init(amount: FoodValue, serving: FoodValue? = nil, nutrients: FoodNutrients, sizes: [FoodSize], density: FoodDensity? = nil, linkUrl: String? = nil, prefilledUrl: String? = nil, imageIds: [UUID]? = nil, barcodes: [FoodBarcode], spawnedUserFoodId: UUID? = nil, spawnedPresetFoodId: UUID? = nil) {
        self.amount = amount
        self.serving = serving
        self.nutrients = nutrients
        self.sizes = sizes
        self.density = density
        self.linkUrl = linkUrl
        self.prefilledUrl = prefilledUrl
        self.imageIds = imageIds
        self.barcodes = barcodes
        self.spawnedUserFoodId = spawnedUserFoodId
        self.spawnedPresetFoodId = spawnedPresetFoodId
    }
}
