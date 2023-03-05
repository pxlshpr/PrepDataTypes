import Foundation

public struct FoodNutrients: Codable, Hashable {
    
    public var energyInKcal: Double
    public var carb: Double
    public var protein: Double
    public var fat: Double
    public var micros: [FoodNutrient]
//    public var energy: FoodLabelValue?
 
    public init(
        energyInKcal: Double,
//        energy: FoodLabelValue? = nil,
        carb: Double,
        protein: Double,
        fat: Double,
        micros: [FoodNutrient]
    ) {
        self.energyInKcal = energyInKcal
        self.carb = carb
        self.protein = protein
        self.fat = fat
        self.micros = micros
//        self.energy = energy
    }
}

public extension FoodNutrients {
    func validate() throws {
        //TODO: Check that we don't have absurd values [50655A1F7E07]
        guard energyInKcal >= 0 else { throw FoodNutrientsError.negativeEnergyValue }
        guard carb >= 0 else { throw FoodNutrientsError.negativeCarbValue }
        guard fat >= 0 else { throw FoodNutrientsError.negativeFatValue }
        guard protein >= 0 else { throw FoodNutrientsError.negativeProteinValue }

        for micro in micros {
            guard (micro.nutrientType != nil || micro.usdaType != nil) else {
                throw FoodNutrientsError.nutrientTypeAndUSDATypeIsNil
            }
            //TODO: Check that we have a valid NutrientUnit here [12C85AAA025D]
            //TODO: Check that we don't have absurd values [50655A1F7E07]

            guard micro.value >= 0 else {
                throw FoodNutrientsError.negativeNutrientValue
            }
        }
    }
}

public struct FoodNutrient: Codable, Hashable {
    /**
     This can only be `nil` for USDA imported nutrients that aren't yet supported (and must therefore have a `usdaType` if so).
     */
    public var nutrientType: NutrientType?
    
    /**
     This is used to store the id of a USDA nutrient.
     */
    public var usdaType: Int16?
    public var value: Double
    public var nutrientUnit: NutrientUnit
    
    public init(nutrientType: NutrientType? = nil, usdaType: Int16? = nil, value: Double, nutrientUnit: NutrientUnit) {
        self.nutrientType = nutrientType
        self.usdaType = usdaType
        self.value = value
        self.nutrientUnit = nutrientUnit
    }
}

public enum FoodNutrientsError: Error {
    case negativeEnergyValue
    case negativeCarbValue
    case negativeFatValue
    case negativeProteinValue
    case negativeNutrientValue
    case nutrientTypeAndUSDATypeIsNil
}
