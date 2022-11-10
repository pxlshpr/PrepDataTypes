import Foundation

public extension FoodQuantity {

    struct Size: Hashable {
        let quantity: Double
        let volumePrefixExplicitUnit: VolumeExplicitUnit?
        let name: String
        let value: Double
        let unit: Unit
    }
}

public extension FoodQuantity.Size {
    init?(foodSize: FoodSize, in food: Food) {
        guard let unit = FoodQuantity.Unit(foodValue: foodSize.value, in: food) else {
            return nil
        }
                
        self.init(
            quantity: foodSize.quantity,
            volumePrefixExplicitUnit: foodSize.volumePrefixExplicitUnit,
            name: foodSize.name,
            value: foodSize.value.value,
            unit: unit
        )
    }
    
    init?(formSize: FormSize, in food: Food, userVolumeUnits: UserExplicitVolumeUnits) {
        guard let size = food.quantitySize(for: formSize.id) else {
            return nil
        }
        self = size
//        guard let quantity = formSize.quantity,
//              let amount = formSize.amount,
//              let unit = FoodQuantity.Unit(
//                formUnit: formSize.unit,
//                food: food,
//                userVolumeUnits: userVolumeUnits
//              )
//        else { return nil }
//
//        let volumePrefixUnit: VolumeExplicitUnit?
//        if let volumePrefixFormUnit = formSize.volumePrefixUnit {
//            guard let volumeExplicitUnit = userVolumeUnits.volumeExplicitUnit(for: volumePrefixFormUnit) else {
//                return nil
//            }
//            volumePrefixUnit = volumeExplicitUnit
//        } else {
//            volumePrefixUnit = nil
//        }
//
//        self.init(
//            quantity: quantity,
//            volumePrefixExplicitUnit: volumePrefixUnit,
//            name: formSize.name,
//            value: amount,
//            unit: unit
//        )
    }
}

public extension VolumeExplicitUnit {
    func scale(against other: VolumeExplicitUnit?) -> Double {
        guard let other else { return 1 }
        return ml / other.ml
    }
}

public extension SizeQuantity {
    var sizeVolumeScale: Double {
        size.volumePrefixScale(for: volumePrefixUnit)
    }
    
    func volumePrefixScale(for otherVolumePrefix: VolumeExplicitUnit?) -> Double {
        guard let volumePrefixUnit, let otherVolumePrefix else {
            return 1
        }
//        return (volumePrefixUnit.ml / otherVolumePrefix.ml) * sizeVolumeScale
        return (volumePrefixUnit.ml / otherVolumePrefix.ml)
    }
}

public extension FoodQuantity.Size {
    
    func volumePrefixScale(for otherVolumePrefix: VolumeExplicitUnit?) -> Double {
        guard let volumePrefixExplicitUnit, let otherVolumePrefix else {
            return 1
        }
        return volumePrefixExplicitUnit.ml / otherVolumePrefix.ml
    }
    
    func namePrefixed(with volumeExplicitUnit: VolumeExplicitUnit?) -> String {
        if let volumeExplicitUnit {
            return "\(volumeExplicitUnit.shortDescription) \(name)"
        } else {
            return prefixedName
        }
    }
    
    var prefixedName: String {
        if let volumePrefixString {
            return "\(volumePrefixString) \(name)"
        } else {
            return name
        }
    }
    
    var volumePrefixString: String? {
        volumePrefixExplicitUnit?.shortDescription
    }

    var unitValue: Double {
        guard quantity > 0 else { return 0 }
        return value / quantity
    }
}
