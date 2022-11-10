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
    
    func servingDescription(using userVolumeUnits: UserExplicitVolumeUnits) -> String? {
        guard let serving = info.serving, let servingDescription else { return nil }

        var volumeSuffix: String = ""
        /// if the serving has a descriptive volume unit, and it isn't one of the user's units, include it in brackets
        if let volumeExplicitUnit = serving.descriptiveVolumeUnit,
            !userVolumeUnits.contains(volumeExplicitUnit)
        {
            volumeSuffix = " (\(volumeExplicitUnit.ml.clean) mL)"
        }
        return servingDescription + volumeSuffix
    }
}

extension FoodValue {
    /// returns either the volume prefix of the size or the volume unit
    var descriptiveVolumeUnit: VolumeExplicitUnit? {
        sizeUnitVolumePrefixExplicitUnit ?? volumeExplicitUnit
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
        
        //TODO: Copy `isVolumeBased` etc to FoodQuantity.Size and use foodQuantitySizes here instead (and remove formSizes)
        for size in formSizes {
            if size.isVolumeBased {
                return true
            }
        }
        return false
    }
}
