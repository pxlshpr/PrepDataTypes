import Foundation

public extension MealFoodItem {
    
    var nutrientScaleFactor: Double {
        guard let foodQuantity = food.quantity(for: amount) else { return 0 }
        return food.nutrientScaleFactor(for: foodQuantity) ?? 0
    }
    
    var scaledValueForEnergyInKcal: Double {
        food.info.nutrients.energyInKcal * nutrientScaleFactor
    }
    
    func scaledValueForMacro(_ macro: Macro) -> Double {
        food.valueForMacro(macro) * nutrientScaleFactor
    }
}

public extension Food {
    func valueForMacro(_ macro: Macro) -> Double {
        switch macro {
        case .carb:
            return info.nutrients.carb
        case .fat:
            return info.nutrients.fat
        case .protein:
            return info.nutrients.protein
        }
    }    
}
