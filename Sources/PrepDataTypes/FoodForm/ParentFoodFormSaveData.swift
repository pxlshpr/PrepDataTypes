import Foundation

public struct ParentFoodFormSaveData {
    
    public var name: String
    public var detail: String?
    public var brand: String?
    public var amount: FoodValue
    public var serving: FoodValue?
    public var sizes: [FoodSize]
    public var density: FoodDensity?
    
    public var forRecipe: Bool
    public var ingredientItems: [IngredientItem]
    
    public init(
        forRecipe: Bool,
        name: String,
        detail: String?,
        brand: String?,
        amount: FoodValue,
        serving: FoodValue? = nil,
        sizes: [FoodSize],
        density: FoodDensity? = nil,
        ingredientItems: [IngredientItem]
    ) {
        self.forRecipe = forRecipe
        self.name = name
        self.detail = detail
        self.brand = brand
        self.amount = amount
        self.serving = serving
        self.sizes = sizes
        self.density = density
        self.ingredientItems = ingredientItems
    }
}
