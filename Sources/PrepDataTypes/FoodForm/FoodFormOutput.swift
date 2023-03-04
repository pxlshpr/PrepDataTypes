#if os(iOS)
import SwiftUI

/**
 Encompasses all the data output by the `FoodForm`.
 */
public struct FoodFormOutput {
    
    public let images: [UUID: UIImage]
    public let fieldsAndSourcesJSONData: Data
    public let shouldPublish: Bool
    public let createForm: UserFoodCreateForm
    
    public init(createForm: UserFoodCreateForm,
         fieldsAndSourcesJSONData: Data,
         images: [UUID : UIImage],
         shouldPublish: Bool
    ) {
        self.images = images
        self.fieldsAndSourcesJSONData = fieldsAndSourcesJSONData
        self.shouldPublish = shouldPublish
        self.createForm = createForm
    }
}

/**
 Encompasses all the data output by the `ParentFoodForm`.
 */
public struct ParentFoodFormOutput {
    
    public let createForm: UserFoodCreateForm
    public let items: [IngredientItem]
    public let forRecipe: Bool
    
    public init(
        createForm: UserFoodCreateForm,
        items: [IngredientItem],
        forRecipe: Bool
    ) {
        self.createForm = createForm
        self.items = items
        self.forRecipe = forRecipe
    }
    
    public var foodType: FoodType {
        forRecipe ? .recipe : .plate
    }
}

#endif
