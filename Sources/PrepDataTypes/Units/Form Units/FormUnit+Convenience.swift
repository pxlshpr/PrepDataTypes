import Foundation

public extension FormUnit {

    init?(foodValue: FoodValue, in food: Food) {
        self.init(foodValue: foodValue, in: food.info.sizes)
    }
    
    //TODO: Quarantined *** TO BE REMOVED ***
    /// We can't use this as converting it to a `FormUnit` loses the explicit volume units
    init?(foodValue: FoodValue, in sizes: [FoodSize]) {
        switch foodValue.unitType {
        case .serving:
            self = .serving
        case .weight:
            guard let weightUnit = foodValue.weightUnit else {
                return nil
            }
            self = .weight(weightUnit)
        case .volume:
            guard let volumeUnit = foodValue.volumeExplicitUnit?.volumeUnit else {
                return nil
            }
            self = .volume(volumeUnit)
        case .size:
            guard let foodSize = sizes.sizeMatchingUnitSizeInFoodValue(foodValue),
                  let formSize = FormSize(foodSize: foodSize, in: sizes)
            else {
                return nil
            }
            self = .size(formSize, foodValue.sizeUnitVolumePrefixExplicitUnit?.volumeUnit)
        }
    }
    
    init?(volumeExplicitUnit: VolumeExplicitUnit) {
        self = .volume(volumeExplicitUnit.volumeUnit)
    }
}

