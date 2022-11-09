import Foundation

public extension FoodQuantity {
    func convert(to unit: Unit) -> FoodQuantity? {
        
        let converted: Double?
        
        switch self.unit {
            
        case .weight(let weightUnit):
            let weight = WeightQuantity(value: value, unit: weightUnit)
            converted = convertWeight(weight, toUnit: unit)
            
        case .volume(let volumeUnit):
            let volume = VolumeQuantity(value: value, unit: volumeUnit)
            converted = convert(volume, to: unit)
            
        case .serving:
            converted = convertFromServings(amount: value, toUnit: unit)
            
        case .size(let size, let volumePrefixUnit):
            let sizeQuantity = SizeQuantity(value, size, volumePrefixUnit)
//            converted = convertSize(sizeUnit, amount: value, toUnit: unit)
            converted = convert(sizeQuantity, to: unit)
        }
        
        guard let converted else { return nil }
        return FoodQuantity(
            value: converted,
            unit: unit,
            food: self.food
        )
    }
}

extension FoodQuantity {
    
    func convert(_ sizeQuantity: SizeQuantity, to unit: Unit) -> Double? {
        
        return nil
        
//        switch toUnit {
//
//        case .weight:
//            //MARK: Size → Weight
//            guard
//                let unitWeightQuantity = size.unitWeightQuantity(in: food),
//                let fromWeightUnit = unitWeightQuantity.unit.weightUnit,
//                let unitWeightAmount = convertWeight(
//                    WeightQuantity(value: amount, unit: fromWeightUnit),
//                    toFormUnit: toUnit
//                )
//            else {
//                return nil
//            }
//            return unitWeightAmount * unitWeightQuantity.value
//        case .volume(let volumeUnit):
//            return nil
//        case .size(let formSize, let volumeUnit):
//            return nil
//        case .serving:
//            guard let unitServings = size.unitServings else { return nil }
//            return unitServings * amount
//        }
    }
    
    // ✅ Tests Passing
    func convert(_ volume: VolumeQuantity, to unit: Unit) -> Double? {
        switch unit {
            
        case .weight(let weightUnit):
            // ✅ Tests Passing
            guard let density = food.info.density else { return nil }
            /// Volume → Weight
            let weight = density.convert(volume: volume)
            /// Volume → VolumeExplicitUnit
            return weight.convert(to: weightUnit)

        case .volume(let volumeExplicitUnit):
            // ✅ Tests Passing
            return volume.convert(to: volumeExplicitUnit)

        case .size(let size, let volumePrefixUnit):
            // ✅ Tests Passing
            guard let unitVolume = size.unitVolume(in: food) else { return nil }
            let converted = unitVolume.convert(to: volume.unit)
            guard converted > 0 else { return nil }
            let volume = volume.value / converted
            return volume * size.volumePrefixScale(for: volumePrefixUnit)

        case .serving:
            // ✅ Tests Passing
            guard let servingVolume = food.servingVolume else { return nil }
            let converted = servingVolume.convert(to: volume.unit)
            guard value > 0 else { return nil }
            return value / converted
        }
    }
    
    func convertFromServings(amount: Double, toUnit: Unit) -> Double? {
        
        guard let serving = food.info.serving, let servingUnit = food.servingUnit else {
            return nil
        }
        //TODO: Reuse servingWeight etc here
        let converted: Double?
        switch servingUnit {
            
        case .weight(let weightUnit):
            let weight = WeightQuantity(value: serving.value, unit: weightUnit)
            converted = convertWeight(weight,toUnit: unit)
            
        case .volume(let volumeUnit):
            converted = nil
            
        case .size(let size, let volumeUnit):
            converted = nil
            
        case .serving:
            /// We shouldn't encounter this
            return nil
        }
        guard let converted else { return nil }
        return converted * amount
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

    func quantitySize(for id: String) -> FoodQuantity.Size? {
        guard let size = size(for: id) else { return nil }
        return FoodQuantity.Size(foodSize: size, in: self)
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
//                  let size = size(for: sizeId),
                  let size = quantitySize(for: sizeId),
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
    
    var servingVolume: VolumeQuantity? {
        
        guard let serving = info.serving else { return nil }
        
        switch serving.unitType {
        case .weight:
            /// If the serving is expressed as a volume, *and* we have a density...
            guard let weightUnit = serving.weightUnit,
                  let density = info.density
            else { return nil }
            
            let weight = WeightQuantity(serving.value, weightUnit)
            return density.convert(weight: weight)

        case .volume:
            guard let volumeExplicitUnit = serving.volumeExplicitUnit else { return nil }
            return .init(serving.value, volumeExplicitUnit)

        case .size:
            guard let sizeId = serving.sizeUnitId,
                  let size = quantitySize(for: sizeId),
                  let unitVolumeOfSize = size.unitVolume(in: self)
            else {
                return nil
            }

            return .init(
                value: unitVolumeOfSize.value * serving.value,
                unit: unitVolumeOfSize.unit
            )
            
        case .serving:
            /// We should never reach here, as a serving of a serving is not possible
            return nil
        }
    }
}

extension FoodQuantity.Size {
    
    /// Returns the unit weight of this size (ie what 1 of it weighs), if applicable. Drills down to the base size if necessary.
    func unitWeight(in food: Food) -> WeightQuantity? {
        /// Protect against zero-divison error
        guard quantity > 0 else { return nil }
        
        switch unit {
        case .weight(let weightUnit):
            return .init(value: (value / quantity), unit: weightUnit)

        case .volume(let volumeExplicitUnit):
            guard let density = food.info.density else { return nil }
            let volume = VolumeQuantity(value: (value / quantity), unit: volumeExplicitUnit)
            return density.convert(volume: volume)

        case .serving:
            guard let servingWeight = food.servingWeight else { return nil }
            return WeightQuantity((servingWeight.value * value) / quantity, servingWeight.unit)

        case .size(let sizeUnit, let volumePrefixUnit):
            guard let unitWeight = sizeUnit.unitWeight(in: food) else { return nil }
            return WeightQuantity((unitWeight.value * value) / quantity, unitWeight.unit)

            //TODO: What do we do about the volumePrefixUnit
        default:
            return nil
        }
    }
    
    /// Returns the unit volume of this size (ie what 1 of it weighs), if applicable. Drills down to the base size if necessary.
    func unitVolume(in food: Food) -> VolumeQuantity? {
        /// Protect against zero-divison error
        guard quantity > 0 else { return nil }
        
        switch unit {
        case .weight(let weightUnit):
            guard let density = food.info.density else { return nil }
            let weight = WeightQuantity((value / quantity), weightUnit)
            return density.convert(weight: weight)

        case .volume(let volumeExplicitUnit):
            return .init((value / quantity), volumeExplicitUnit)

        case .serving:
            guard let servingVolume = food.servingVolume else { return nil }
            return VolumeQuantity((servingVolume.value * value) / quantity, servingVolume.unit)

        case .size(let sizeUnit, let volumePrefixUnit):
            guard let unitVolume = sizeUnit.unitVolume(in: food) else { return nil }
            return VolumeQuantity((unitVolume.value * value) / quantity, unitVolume.unit)

            //TODO: What do we do about the volumePrefixUnit
        default:
            return nil
        }
    }
}

//extension FormSize {
//    /**
//     Returns how many servings this size represents, if applicable. Drills down to the base size if necessary.
//
//     Basic case:
//     - 3 x **balls** = 1 serving
//     *This would imply that 1 ball is 1/3 servings*
//
//     Hierarchical case:
//     - 2 x **sleeves** = 16 balls
//     - 3 x balls = 1 serving
//     *This implies that 1 sleeve would be  2.5 servings*
//     */
//    var unitServings: Double? {
//        guard isServingBased, let amount, let quantity else { return nil }
//        if unit == .serving {
//            return amount / quantity
//        } else if case .size(let sizeUnit, let volumePrefixUnit) = unit {
//            guard let unitServings = sizeUnit.unitServings else {
//                return nil
//            }
//            return (unitServings * amount) / quantity
//
//            //TODO: What do we do about the volumePrefixUnit
//        } else {
//            return nil
//        }
//    }
//
//    /**
//     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
//     This is **Quarantined**
//     */
//    func unitWeightQuantity(in food: Food) -> FoodQuantity? {
//        guard let amount, let quantity else { return nil }
//
//        switch unit {
//        case .weight(let weightUnit):
//            return FoodQuantity(
//                amount: (amount / quantity),
//                unit: .weight(weightUnit),
//                food: food
//            )
//
//        case .serving:
//            guard let servingWeightQuantity = food.servingWeightQuantity else {
//                return nil
//            }
//
//            return FoodQuantity(
//                amount: (servingWeightQuantity.value * amount) / quantity,
//                unit: servingWeightQuantity.unit,
//                food: food
//            )
//
//        case .size(let sizeUnit, let volumePrefixUnit):
//            guard let unitWeightQuantity = sizeUnit.unitWeightQuantity(in: food) else {
//                return nil
//            }
//            return FoodQuantity(
//                amount: (unitWeightQuantity.value * amount) / quantity,
//                unit: unitWeightQuantity.unit,
//                food: food
//            )
//
//            //TODO: What do we do about the volumePrefixUnit
//        default:
//            return nil
//        }
//    }
//
//    /**
//     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
//     */
//    func unitWeight(in food: Food) -> WeightQuantity? {
//        guard let amount, let quantity else { return nil }
//
//        switch unit {
//        case .weight(let weightUnit):
//            return .init(value: (amount / quantity), unit: weightUnit)
//
//        case .serving:
//            guard let servingWeight = food.servingWeight else {
//                return nil
//            }
//
//            return .init(
//                value: (servingWeight.value * amount) / quantity,
//                unit: servingWeight.unit
//            )
//
//        case .size(let sizeUnit, let volumePrefixUnit):
//            guard let unitWeight = sizeUnit.unitWeight(in: food) else {
//                return nil
//            }
//            return .init(
//                value: (unitWeight.value * amount) / quantity,
//                unit: unitWeight.unit
//            )
//
//            //TODO: What do we do about the volumePrefixUnit
//        default:
//            return nil
//        }
//    }
//}

//extension FoodSize {
//    /**
//     Returns the quantity representing how much 1 of this size weights, if applicable. Drills down to the base size if necessary.
//     */
//    func unitWeight(in food: Food) -> WeightQuantity? {
//        /// Protect against zero-divison error
//        guard quantity > 0 else { return nil }
//        let unitValue = (value.value / quantity)
//
//        switch value.unitType {
//        case .weight:
//            guard let weightUnit = value.weightUnit else { return nil }
//            return WeightQuantity(value: unitValue, unit: weightUnit)
//
//        case .volume:
//            guard let volumeExplicitUnit = value.volumeExplicitUnit else { return nil }
//            guard let density = food.info.density else { return nil }
//            let volume = VolumeQuantity(value: unitValue, unit: volumeExplicitUnit)
//            return density.convert(volume: volume)
//
//        case .size:
//            guard let sizeId = value.sizeUnitId,
//                  let size = food.size(for: sizeId),
//                  let unitWeightOfSize = size.unitWeight(in: food)
//            else { return nil }
//            return .init(value: unitValue * unitWeightOfSize.value, unit: unitWeightOfSize.unit)
//
//        default:
//            return nil
//        }
//    }
//
//    /**
//     Returns the volume representing 1 of this size, if applicable. Drills down to the base size if necessary.
//     */
//    func unitVolume(in food: Food) -> VolumeQuantity? {
//        /// Protect against zero-divison error
//        guard quantity > 0 else { return nil }
//        let unitValue = (value.value / quantity)
//
//        switch value.unitType {
//        case .weight:
//            guard let weightUnit = value.weightUnit else { return nil }
//            guard let density = food.info.density else { return nil }
//            let weight = WeightQuantity(unitValue, weightUnit)
//            return density.convert(weight: weight)
//
//        case .volume:
//            guard let volumeExplicitUnit = value.volumeExplicitUnit else { return nil }
//            return VolumeQuantity(unitValue, volumeExplicitUnit)
//
//        case .size:
//            guard let sizeId = value.sizeUnitId,
//                  let size = food.size(for: sizeId),
//                  let unitVolumeOfSize = size.unitVolume(in: food)
//            else { return nil }
//            return .init(unitValue * unitVolumeOfSize.value, unitVolumeOfSize.unit)
//
//        default:
//            return nil
//        }
//    }
//}

// ✅ Tests Passing
public extension FoodQuantity {
    
    // ✅ Tests Passing
    func convertWeight(_ weight: WeightQuantity, toUnit: Unit) -> Double? {
        switch toUnit {
            
        case .weight(let weightUnit):
            // ✅ Tests Passing
            return weight.convert(to: weightUnit)
            
        case .volume(let volumeExplicitUnit):
            // ✅ Tests Passing
            /// Get explicit unit and density
            guard let density = food.info.density else { return nil }
            /// Weight → Volume
            let volume = density.convert(weight: weight)
            /// Volume → VolumeExplicitUnit
            return volume.convert(to: volumeExplicitUnit)
            
        case .size(let size, let volumePrefixUnit):
            // ✅ Tests Passing
            guard let unitWeight = size.unitWeight(in: food) else { return nil }
            let converted = unitWeight.convert(to: weight.unit)
            guard converted > 0 else { return nil }
            let weight = weight.value / converted
            return weight * size.volumePrefixScale(for: volumePrefixUnit)
            
        case .serving:
            // ✅ Tests Passing
            guard let servingWeight = food.servingWeight else { return nil }
            let converted = servingWeight.convert(to: weight.unit)
            guard value > 0 else { return nil }
            return value / converted
        }
    }
}

