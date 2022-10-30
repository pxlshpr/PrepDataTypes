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
#endif
