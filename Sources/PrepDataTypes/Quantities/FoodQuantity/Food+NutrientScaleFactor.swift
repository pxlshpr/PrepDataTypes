import Foundation

public extension Food {
    
    /**
     Given a quantity that we are after, this returns the nutrient scale factor to apply to its nutrients in order to get scaled values.
     */
    func nutrientScaleFactor(for quantity: FoodQuantity) -> Double? {
        
        guard let amountQuantity, quantity.food.id == self.id else { return nil }
        
        /// now convert the quantity we're after into the units that the food amount is described in
        guard let converted = amountQuantity.convert(to: quantity.unit) else { return nil }
        /**
         So now we have the following:
         amountQuantity.value foodAmount = converted.value unit
         y foodAmount = quantity.value unit
         
         solve for y, and the scaleFactor is y / 1
         */
        let y = (quantity.value * amountQuantity.value) / converted.value
        return y/amountQuantity.value
    }
    
    /**
     Returns the `FoodQuantity` that represents what the nutrients have been described for.
     
     Note: If the unit is `.serving` and we have the `servingQuantity: FoodQuantity?`, then that is returned—otherwise we simply return the `FoodQuantity` in terms of `.serving`s.
     */
    var amountQuantity: FoodQuantity? {
        switch info.amount.unitType {
        case .weight, .volume, .size:
            guard let unit = FoodQuantity.Unit(foodValue: info.amount, in: self) else { return nil }
            return FoodQuantity(value: info.amount.value, unit: unit, food: self)
        case .serving:
            return servingQuantity ?? FoodQuantity(value: info.amount.value, unit: .serving, food: self)
        }
    }
    
    var servingQuantity: FoodQuantity? {
        guard let serving = info.serving,
              let unit = FoodQuantity.Unit(foodValue: serving, in: self)
        else { return nil }
        return FoodQuantity(value: info.amount.value * serving.value, unit: unit, food: self)
    }
}
