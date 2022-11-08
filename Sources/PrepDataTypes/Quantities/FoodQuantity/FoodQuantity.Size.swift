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

extension FoodQuantity.Size {
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
}

extension FoodQuantity.Size {
    
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

}
