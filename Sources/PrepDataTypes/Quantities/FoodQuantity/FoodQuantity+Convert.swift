import Foundation

public extension FoodQuantity {
    
    func convert(
        to toFormUnit: FormUnit,
        with explicitVolumeUnits: UserExplicitVolumeUnits = .defaultUnits
    ) -> FoodQuantity? {
        
        let converted: Double?
        
        switch self.unit {
            
        case .weight(let weightUnit):
            let weight = WeightQuantity(value: value, unit: weightUnit)
            converted = convertWeight(weight, toFormUnit: toFormUnit, with: explicitVolumeUnits)
            
        case .volume(let volumeUnit):
            converted = nil
            
        case .serving:
            converted = convertFromServings(amount: value, toFormUnit: toFormUnit, with: explicitVolumeUnits)
            
        case .size(let sizeUnit, let sizeVolumePrefix):
            converted = convertSize(sizeUnit, amount: value, toFormUnit: toFormUnit, with: explicitVolumeUnits)
        }
        
        guard let converted else { return nil }
        return FoodQuantity(
            amount: converted,
            unit: toFormUnit,
            food: self.food
        )
    }
    
    func convertWeight(
        _ weight: WeightQuantity,
        toFormUnit: FormUnit,
        with userVolumeUnits: UserExplicitVolumeUnits
    ) -> Double? {
        switch toFormUnit {
            
        case .weight(let weightUnit):
            // ✅ Tests Passing
            return weight.convert(to: weightUnit)
            //            return weight.unit.convert(amount: amount, to: weightUnit)
            
        case .volume(let volumeUnit):
            // ✅ Tests Passing

            /// Get explicit unit and density
            let volumeExplicitUnit = userVolumeUnits.volumeExplicitUnit(for: volumeUnit)
            guard let density = food.info.density else { return nil }
            /// Weight → Volume
            let volume = density.convert(weight: weight)
            /// Volume → VolumeExplicitUnit
            return volume.convert(to: volumeExplicitUnit)
            
        case .size(let formSize, let volumeUnit):
            return nil
            
        case .serving:
            guard let servingWeight = food.servingWeight else { return nil }
            let converted = servingWeight.convert(to: weight.unit)
            guard value > 0 else { return nil }
            return value / converted
        }
    }
    
    func convertFromServings(
        amount: Double,
        toFormUnit: FormUnit,
        with explicitVolumeUnits: UserExplicitVolumeUnits
    ) -> Double? {
        
        guard let serving = food.info.serving, let servingUnit = food.servingUnit else {
            return nil
        }
        //TODO: Reuse servingWeight etc here
        let converted: Double?
        switch servingUnit {
            
        case .weight(let weightUnit):
            let weight = WeightQuantity(value: serving.value, unit: weightUnit)
            converted = convertWeight(weight,toFormUnit: toFormUnit, with: explicitVolumeUnits)
            
        case .volume(let volumeUnit):
            converted = nil
            
        case .size(let formSize, let volumeUnit):
            converted = nil
            
        case .serving:
            /// We shouldn't encounter this
            return nil
        }
        guard let converted else { return nil }
        return converted * amount
    }
    
    func convertSize(
        _ size: FormSize,
        amount: Double,
        toFormUnit: FormUnit,
        with explicitVolumeUnits: UserExplicitVolumeUnits
    ) -> Double? {
        
        switch toFormUnit {
            
        case .weight:
            //MARK: Size → Weight
            guard
                let unitWeightQuantity = size.unitWeightQuantity(in: food),
                let fromWeightUnit = unitWeightQuantity.unit.weightUnit,
                let unitWeightAmount = convertWeight(
                    WeightQuantity(value: amount, unit: fromWeightUnit),
                    toFormUnit: toFormUnit,
                    with: explicitVolumeUnits
                )
            else {
                return nil
            }
            return unitWeightAmount * unitWeightQuantity.value
        case .volume(let volumeUnit):
            return nil
        case .size(let formSize, let volumeUnit):
            return nil
        case .serving:
            guard let unitServings = size.unitServings else { return nil }
            return unitServings * amount
        }
    }
    
}

extension Food {
    
    //TODO: Quarantined *** TO BE REMOVED ***
    /// We can't use this as converting it to a `FormUnit` loses the explicit volume units
    var servingUnit: FormUnit? {
        guard let serving = info.serving else { return nil }
        return FormUnit(foodValue: serving, in: self)
    }
    
    func size(for id: String) -> FoodSize? {
        info.sizes.first(where: { $0.id == id })
    }
    
    //TODO: Quarantined
    var servingWeightQuantity: FoodQuantity? {
        guard let serving = info.serving,
              let servingUnit
        else {
            return nil
        }
        switch servingUnit {
        case .weight(let weightUnit):
            return FoodQuantity(
                amount: serving.value,
                unit: .weight(weightUnit),
                food: self
            )
        case .size(let sizeUnit, let sizeVolumePrefix):
            guard let sizeUnitWeightQuantity = sizeUnit.unitWeightQuantity(in: self) else {
                return nil
            }
            return FoodQuantity(
                amount: sizeUnitWeightQuantity.value * serving.value,
                unit: sizeUnitWeightQuantity.unit,
                food: self
            )
        default:
            return nil
        }
    }
    
    var servingWeight: WeightQuantity? {
        
        guard let serving = info.serving else { return nil }
        
        switch serving.unitType {
        case .weight:
            guard let weightUnit = serving.weightUnit else { return nil }
            return .init(value: serving.value, unit: weightUnit)
        case .volume:
            /// If the serving is expressed as a volume, *and* we have a density...
            guard let volumeExplicitUnit = serving.volumeExplicitUnit,
                  let density = info.density else {
                return nil
            }
            
            let volume = VolumeQuantity(value: serving.value, unit: volumeExplicitUnit)
            return density.convert(volume: volume)

        case .size:
            
            guard let sizeId = serving.sizeUnitId,
                  let size = size(for: sizeId),
                  let unitWeightOfSize = size.unitWeight(in: self)
            else {
                return nil
            }
            
            return .init(
                value: unitWeightOfSize.value * serving.value,
                unit: unitWeightOfSize.unit
            )
            
        case .serving:
            /// We should never reach here, as a serving of a serving is not possible
            return nil
        }
    }
}

extension FormSize {
    /**
     Returns how many servings this size represents, if applicable. Drills down to the base size if necessary.
     
     Basic case:
     - 3 x **balls** = 1 serving
     *This would imply that 1 ball is 1/3 servings*
     
     Hierarchical case:
     - 2 x **sleeves** = 16 balls
     - 3 x balls = 1 serving
     *This implies that 1 sleeve would be  2.5 servings*
     */
    var unitServings: Double? {
        guard isServingBased, let amount, let quantity else { return nil }
        if unit == .serving {
            return amount / quantity
        } else if case .size(let sizeUnit, let volumePrefixUnit) = unit {
            guard let unitServings = sizeUnit.unitServings else {
                return nil
            }
            return (unitServings * amount) / quantity
            
            //TODO: What do we do about the volumePrefixUnit
        } else {
            return nil
        }
    }
    
    /**
     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
     This is **Quarantined**
     */
    func unitWeightQuantity(in food: Food) -> FoodQuantity? {
        guard let amount, let quantity else { return nil }
        
        switch unit {
        case .weight(let weightUnit):
            return FoodQuantity(
                amount: (amount / quantity),
                unit: .weight(weightUnit),
                food: food
            )
            
        case .serving:
            guard let servingWeightQuantity = food.servingWeightQuantity else {
                return nil
            }
            
            return FoodQuantity(
                amount: (servingWeightQuantity.value * amount) / quantity,
                unit: servingWeightQuantity.unit,
                food: food
            )
            
        case .size(let sizeUnit, let volumePrefixUnit):
            guard let unitWeightQuantity = sizeUnit.unitWeightQuantity(in: food) else {
                return nil
            }
            return FoodQuantity(
                amount: (unitWeightQuantity.value * amount) / quantity,
                unit: unitWeightQuantity.unit,
                food: food
            )
            
            //TODO: What do we do about the volumePrefixUnit
        default:
            return nil
        }
    }
    
    /**
     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
     */
    func unitWeight(in food: Food) -> WeightQuantity? {
        guard let amount, let quantity else { return nil }
        
        switch unit {
        case .weight(let weightUnit):
            return .init(value: (amount / quantity), unit: weightUnit)
            
        case .serving:
            guard let servingWeight = food.servingWeight else {
                return nil
            }
            
            return .init(
                value: (servingWeight.value * amount) / quantity,
                unit: servingWeight.unit
            )
            
        case .size(let sizeUnit, let volumePrefixUnit):
            guard let unitWeight = sizeUnit.unitWeight(in: food) else {
                return nil
            }
            return .init(
                value: (unitWeight.value * amount) / quantity,
                unit: unitWeight.unit
            )
            
            //TODO: What do we do about the volumePrefixUnit
        default:
            return nil
        }
    }
}

//extension WeightUnit {
//    func convert(amount: Double, to otherWeightUnit: WeightUnit) -> Double {
//        let grams = self.g * amount
//        let otherGrams = otherWeightUnit.g
//        return grams / otherGrams
//    }
//}


//extension VolumeExplicitUnit {
//    func convert(amount: Double, to otherVolumeExplicitUnit: VolumeExplicitUnit) -> Double {
//        let ml = self.ml * amount
//        let otherMls = otherVolumeExplicitUnit.ml
//        return ml / otherMls
//    }
//}
