import Foundation

public extension Food {
    
    var foodQuantitySizes: [FoodQuantity.Size] {
        info.sizes.compactMap { foodSize in
            FoodQuantity.Size(foodSize: foodSize, in: self)
        }
    }
    
    //TODO: Stop using this *** TO BE REMOVED ***
    var formSizes: [FormSize] {
        info.sizes.compactMap { foodSize in
            FormSize(foodSize: foodSize, in: info.sizes)
        }
    }
    
    var servingDescription: String? {
        guard let serving = info.serving else { return nil }
        return "\(serving.value.cleanAmount) \(serving.unitDescription(sizes: info.sizes))"
    }
}

public extension Food {
    var canBeMeasuredInWeight: Bool {
        if info.density != nil {
            return true
        }
        
        if info.amount.isWeightBased(in: self) {
            return true
        }
        if let serving = info.serving, serving.isWeightBased(in: self) {
            return true
        }
        for size in formSizes {
            if size.isWeightBased {
                return true
            }
        }
        return false
    }
    
    var canBeMeasuredInVolume: Bool {
        if info.density != nil {
            return true
        }
        
        if info.amount.isVolumeBased(in: self) {
            return true
        }
        if let serving = info.serving, serving.isVolumeBased(in: self) {
            return true
        }
        for size in formSizes {
            if size.isVolumeBased {
                return true
            }
        }
        return false
    }
}
