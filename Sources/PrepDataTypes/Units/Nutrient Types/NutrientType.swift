import Foundation

public enum NutrientType: Int16, CaseIterable, Codable {
    
    /// Fats
    case saturatedFat = 1
    case monounsaturatedFat
    case polyunsaturatedFat
    case transFat
    case cholesterol
    
    /// Fibers
    case dietaryFiber = 50
    case solubleFiber
    case insolubleFiber
    
    /// Sugars
    case sugars = 100
    case addedSugars
    case sugarAlcohols
    
    /// Minerals
    case calcium = 150
    case chloride
    case chromium
    case copper
    case iodine
    case iron
    case magnesium
    case manganese
    case molybdenum
    case phosphorus
    case potassium
    case selenium
    case sodium
    case zinc
    
    /// Vitamins
    case vitaminA = 200
    case vitaminB1_thiamine
    case vitaminB2_riboflavin
    case vitaminB3_niacin
    case vitaminB5_pantothenicAcid
    case vitaminB6_pyridoxine
    case vitaminB7_biotin
    case vitaminB9_folate
    case vitaminB9_folicAcid
    case vitaminB12_cobalamin
    case vitaminC_ascorbicAcid
    case vitaminD_calciferol
    case vitaminE
    case vitaminK1_phylloquinone
    case vitaminK2_menaquinone
    
    case choline
    
    /// Misc
    case caffeine = 250
    case ethanol
    case taurine
    case polyols
    case gluten
    case starch
    case salt
    
    /// **For internal-use only**
    case energyWithoutDietaryFibre
    case water = 500
    case freeSugars
    case ash
    
    /// Vitamin Related
    case preformedVitaminARetinol
    case betaCarotene
    case provitaminABetaCaroteneEquivalents
    
    case niacinDerivedEquivalents
    
    case totalFolates
    case dietaryFolateEquivalents
    case alphaTocopherol
    
    /// Essential Amino Acids
    case tryptophan
    
    /// Fatty Acids
    case linoleicAcid
    case alphaLinolenicAcid
    case eicosapentaenoicAcid
    case docosapentaenoicAcid
    case docosahexaenoicAcid
}

extension NutrientType {
    public static func types(inGroup group: NutrientTypeGroup) -> [NutrientType] {
        allCases.filter { $0.group == group}
    }
    
    public static var vitamins: [NutrientType] {
        types(inGroup: .vitamins)
    }
    
    public static var minerals: [NutrientType] {
        types(inGroup: .minerals)
    }
    
    public static var misc: [NutrientType] {
        types(inGroup: .misc)
    }
    
    public var group: NutrientTypeGroup? {
        switch self {
        case .saturatedFat, .monounsaturatedFat, .polyunsaturatedFat, .transFat, .cholesterol:
            return .fats
        case .dietaryFiber, .solubleFiber, .insolubleFiber:
            return .fibers
        case .sugars, .addedSugars, .sugarAlcohols:
            return .sugars
        case .calcium, .chloride, .chromium, .copper, .iodine, .iron, .magnesium, .manganese, .molybdenum, .phosphorus, .potassium, .selenium, .sodium, .zinc:
            return .minerals
        case .vitaminA, .vitaminB1_thiamine, .vitaminB2_riboflavin, .vitaminB3_niacin, .vitaminB5_pantothenicAcid, .vitaminB6_pyridoxine, .vitaminB7_biotin, .vitaminB9_folate, .vitaminB9_folicAcid, .vitaminB12_cobalamin, .vitaminC_ascorbicAcid, .vitaminD_calciferol, .vitaminE, .vitaminK1_phylloquinone, .vitaminK2_menaquinone:
            return .vitamins
        case .caffeine, .ethanol, .taurine, .polyols, .gluten, .starch, .salt, .choline:
            return .misc
        default:
            return nil
        }
    }
    
    public var units: [NutrientUnit] {
        switch self {
        case .cholesterol, .calcium, .chloride, .copper, .iron, .magnesium, .manganese, .phosphorus, .potassium, .sodium, .zinc, .vitaminC_ascorbicAcid, .vitaminB6_pyridoxine, .choline, .vitaminB5_pantothenicAcid, .vitaminB2_riboflavin, .vitaminB1_thiamine, .caffeine, .vitaminK2_menaquinone, .taurine:
            return [.mg]
        case .chromium, .iodine, .molybdenum, .selenium, .vitaminB12_cobalamin, .vitaminK1_phylloquinone, .vitaminB7_biotin, .vitaminB9_folicAcid:
            return [.mcg]
        case .vitaminA:
            return [.mcgRAE, .IU]
        case .vitaminD_calciferol:
            return [.mcg, .IU]
        case .vitaminE:
            return [.mgAT, .IU]
        case .vitaminB9_folate:
            return [.mcgDFE, .mcg]
        case .vitaminB3_niacin:
            return [.mgNE, .mg]
        default:
            return [.g]
        }
    }
    
    public var sortPosition: Int {
        let orderedArray: [NutrientType] = [
            .saturatedFat,
            .monounsaturatedFat,
            .polyunsaturatedFat,
            .transFat,
            .cholesterol,
            .dietaryFiber,
            .solubleFiber,
            .insolubleFiber,
            .sugars,
            .addedSugars,
            .sugarAlcohols,
            .calcium,
            .chloride,
            .chromium,
            .copper,
            .iodine,
            .iron,
            .magnesium,
            .manganese,
            .molybdenum,
            .phosphorus,
            .potassium,
            .selenium,
            .sodium,
            .zinc,
            .vitaminA,
            .vitaminB1_thiamine,
            .vitaminB2_riboflavin,
            .vitaminB3_niacin,
            .vitaminB5_pantothenicAcid,
            .vitaminB6_pyridoxine,
            .vitaminB7_biotin,
            .vitaminB9_folate,
            .vitaminB9_folicAcid,
            .vitaminB12_cobalamin,
            .vitaminC_ascorbicAcid,
            .vitaminD_calciferol,
            .vitaminE,
            .vitaminK1_phylloquinone,
            .vitaminK2_menaquinone,
            .caffeine,
            .ethanol,
            .gluten,
            .polyols,
            .salt,
            .starch,
            .taurine,
            .choline,
        ]
        guard let index = orderedArray.firstIndex(of: self) else {
            return 0
        }
        return index + 1
//        switch self {
//        case .saturatedFat:
//            return 1
//        case .monounsaturatedFat:
//            return 2
//        case .polyunsaturatedFat:
//            return 3
//        case .transFat:
//            return 4
//        case .cholesterol:
//            return 5
//        case .dietaryFiber:
//            return 6
//        case .solubleFiber:
//            return 7
//        case .insolubleFiber:
//            return 8
//        case .sugars:
//            return 9
//        case .addedSugars:
//            return 10
//        case .sugarAlcohols:
//            return 11
//        case .calcium:
//            return 12
//        case .chloride:
//            return 13
//        case .chromium:
//            return 14
//        case .copper:
//            return 15
//        case .iodine:
//            return 16
//        case .iron:
//            return 17
//        case .magnesium:
//            return 18
//        case .manganese:
//            return 19
//        case .molybdenum:
//            return 20
//        case .phosphorus:
//            return 21
//        case .potassium:
//            return 22
//        case .selenium:
//            return 23
//        case .sodium:
//            return 24
//        case .zinc:
//            return 25
//        case .vitaminA:
//            return 26
//        case .vitaminB1:
//
//        case .vitaminB2:
//
//        case .vitaminB3:
//
//        case .vitaminB6:
//            return 27
//        case .vitaminB12:
//            return 28
//        case .vitaminC:
//            return 29
//        case .vitaminD:
//            return 30
//        case .vitaminE:
//            return 31
//        case .vitaminK:
//            return 32
//        case .vitaminK2:
//
//        case .biotin:
//            return 33
//        case .cobalamin:
//            <#code#>
//        case .choline:
//            return 34
//        case .folate:
//            return 35
//        case .folicAcid:
//            <#code#>
//        case .niacin:
//            return 36
//        case .pantothenicAcid:
//            return 37
//        case .riboflavin:
//            return 38
//        case .thiamin:
//            return 39
//        case .caffeine:
//            return 40
//        case .ethanol:
//            return 41
//        case .gluten:
//            return
//        case .polyols:
//            return
//        case .salt:
//
//        case .starch:
//
//        case .taurine:
//
//
//        }
    }
}

extension NutrientType {
    public var vitaminChemicalName: String? {
        switch self {
        case .vitaminB1_thiamine:
            return "Thiamine"
        case .vitaminB2_riboflavin:
            return "Riboflavin"
        case .vitaminB3_niacin:
            return "Niacin"
        case .vitaminB5_pantothenicAcid:
            return "Pantothenic Acid"
        case .vitaminB6_pyridoxine:
            return "Pyridoxine"
        case .vitaminB7_biotin:
            return "Biotin"
        case .vitaminB9_folate:
            return "Folate"
        case .vitaminB9_folicAcid:
            return "Folic Acid"
        case .vitaminB12_cobalamin:
            return "Cobalamin"
        case .vitaminC_ascorbicAcid:
            return "Ascorbic Acid"
        case .vitaminD_calciferol:
            return "Calciferol"
        case .vitaminK1_phylloquinone:
            return "Phylloquinone"
        case .vitaminK2_menaquinone:
            return "Menaquinone"
        default:
            return nil
        }
    }
    
    public var vitaminLetterName: String? {
        switch self {
        case .vitaminA:
            return "A"
        case .vitaminB1_thiamine:
            return "B1"
        case .vitaminB2_riboflavin:
            return "B2"
        case .vitaminB3_niacin:
            return "B3"
        case .vitaminB5_pantothenicAcid:
            return "B5"
        case .vitaminB6_pyridoxine:
            return "B6"
        case .vitaminB7_biotin:
            return "B7"
        case .vitaminB9_folate:
            return "B9"
        case .vitaminB9_folicAcid:
            return "B9"
        case .vitaminB12_cobalamin:
            return "B12"
        case .vitaminC_ascorbicAcid:
            return "C"
        case .vitaminD_calciferol:
            return "D"
        case .vitaminE:
            return "E"
        case .vitaminK1_phylloquinone:
            return "K1"
        case .vitaminK2_menaquinone:
            return "K2"
        default:
            return nil
        }
    }
    public var description: String {
        switch self {
        case .saturatedFat:
            return "Saturated Fat"
        case .monounsaturatedFat:
            return "Monounsaturated Fat"
        case .polyunsaturatedFat:
            return "Polyunsaturated Fat"
        case .transFat:
            return "Trans Fat"
        case .cholesterol:
            return "Cholesterol"
        case .dietaryFiber:
            return "Dietary Fiber"
        case .solubleFiber:
            return "Soluble Fiber"
        case .insolubleFiber:
            return "Insoluble Fiber"
        case .sugars:
            return "Sugars"
        case .addedSugars:
            return "Added Sugars"
        case .sugarAlcohols:
            return "Sugar Alcohols"
        case .calcium:
            return "Calcium"
        case .chloride:
            return "Chloride"
        case .chromium:
            return "Chromium"
        case .copper:
            return "Copper"
        case .iodine:
            return "Iodine"
        case .iron:
            return "Iron"
        case .magnesium:
            return "Magnesium"
        case .manganese:
            return "Manganese"
        case .molybdenum:
            return "Molybdenum"
        case .phosphorus:
            return "Phosphorus"
        case .potassium:
            return "Potassium"
        case .selenium:
            return "Selenium"
        case .sodium:
            return "Sodium"
        case .zinc:
            return "Zinc"
            
            
        case .vitaminA:
            return "Vitamin A"
        case .vitaminB1_thiamine:
            return "Thiamine (B1)"
        case .vitaminB2_riboflavin:
            return "Riboflavin (B2)"
        case .vitaminB3_niacin:
            return "Niacin (B3)"
        case .vitaminB5_pantothenicAcid:
            return "Pantothenic Acid (B5)"
        case .vitaminB6_pyridoxine:
            return "Pyridoxine (B6)"
        case .vitaminB7_biotin:
            return "Biotin (B7)"
        case .vitaminB9_folate:
            return "Folate (B9)"
        case .vitaminB9_folicAcid:
            return "Folic Acid (B9)"
        case .vitaminB12_cobalamin:
            return "Cobalamin (B12)"
        case .vitaminC_ascorbicAcid:
            return "Vitamin C"
        case .vitaminD_calciferol:
            return "Vitamin D"
        case .vitaminE:
            return "Vitamin E"
        case .vitaminK1_phylloquinone:
            return "Vitamin K1"
        case .vitaminK2_menaquinone:
            return "Vitamin K2"
            
        case .caffeine:
            return "Caffeine"
        case .ethanol:
            return "Ethanol"
        case .taurine:
            return "Taurine"
        case .polyols:
            return "Polyols"
        case .gluten:
            return "Gluten"
        case .starch:
            return "Starch"
        case .salt:
            return "Salt"
            
        case .choline:
            return "Choline"

        case .energyWithoutDietaryFibre:
            return "Energy without Dietary Fibre"
        case .water:
            return "Water"
        case .freeSugars:
            return "Free Sugars"
            
        case .ash:
            return "Ash"
        case .preformedVitaminARetinol:
            return "Preformed Vitamin A (Retinol)"
        case .betaCarotene:
            return "Beta-carotene"
        case .provitaminABetaCaroteneEquivalents:
            return "Provitamin A (b-carotene equivalents)"
            
        case .niacinDerivedEquivalents:
            return "Niacin Derived Equivalents"
        case .totalFolates:
            return "Total Folates"
        case .dietaryFolateEquivalents:
            return "Dietary Folate Equivalents"
        case .alphaTocopherol:
            return "Alpha Tocopherol"
        case .tryptophan:
            return "Tryptophan"
        case .linoleicAcid:
            return "Linoleic Acid"
        case .alphaLinolenicAcid:
            return "Alpha-linolenic Acid"
        case .eicosapentaenoicAcid:
            return "Eicosapentaenoic Acid"
        case .docosapentaenoicAcid:
            return "Docosapentaenoic Acid"
        case .docosahexaenoicAcid:
            return "Docosahexaenoic Acid"
        }
    }
    
    /// Taken from: https://www.fda.gov/media/135301/download, unless marked
    public var dailyValue: (Double, NutrientUnit)? {
        switch self {
        case .saturatedFat:
            return (20, .g)
        case .monounsaturatedFat:
            /// https://news.christianacare.org/2013/04/nutrition-numbers-revealed-fat-intake/
            return (44, .g)
        case .polyunsaturatedFat:
            /// https://news.christianacare.org/2013/04/nutrition-numbers-revealed-fat-intake/
            return (22, .g)
        case .transFat:
            /// https://www.who.int/news-room/questions-and-answers/item/nutrition-trans-fat
            return (2.2, .g)
        case .cholesterol:
            return (300, .mg)
        case .dietaryFiber:
            return (28, .g)
        case .solubleFiber:
            /// "with about one-fourth — 6 to 8 grams per day — coming from soluble fiber." https://www.ucsfhealth.org/education/increasing-fiber-intake
            return (7, .g)
        case .insolubleFiber:
            /// "with about one-fourth — 6 to 8 grams per day — coming from soluble fiber." https://www.ucsfhealth.org/education/increasing-fiber-intake
            return (21, .g)
        case .sugars:
            /// Adding `.addedSugars` + free sugars [from here](https://www.nhs.uk/live-well/eat-well/food-types/how-does-sugar-in-our-diet-affect-our-health/)
            return (80, .g)
        case .addedSugars:
            return (50, .g)
        case .sugarAlcohols:
            /// https://www.goodrx.com/well-being/diet-nutrition/what-are-sugar-alcohols-and-are-they-healthy
            return (15, .g)
        case .calcium:
            return (1300, .mg)
        case .chloride:
            return (2300, .mg)
        case .chromium:
            return (35, .mcg)
        case .copper:
            return (0.9, .mg)
        case .iodine:
            return (150, .mcg)
        case .iron:
            return (18, .mg)
        case .magnesium:
            return (420, .mg)
        case .manganese:
            return (2.3, .mg)
        case .molybdenum:
            return (45, .mcg)
        case .phosphorus:
            return (1250, .mg)
        case .potassium:
            return (4700, .mg)
        case .selenium:
            return (55, .mcg)
        case .sodium:
            return (2300, .mg)
        case .zinc:
            return (11, .mg)
        case .vitaminA:
            return (900, .mcgRAE)
        case .vitaminB6_pyridoxine:
            return (1.7, .mg)
        case .vitaminB12_cobalamin:
            return (2.4, .mcg)
        case .vitaminC_ascorbicAcid:
            return (90, .mg)
        case .vitaminD_calciferol:
            return (20, .mcg)
        case .vitaminE:
            return (15, .mgAT)
        case .vitaminK1_phylloquinone:
            return (120, .mcg)
        case .vitaminB7_biotin:
            return (30, .mcg)
        case .choline:
            return (550, .mg)
        case .vitaminB9_folate:
            return (400, .mcgDFE)
        case .vitaminB3_niacin:
            return (16, .mgNE)
        case .vitaminB5_pantothenicAcid:
            return (5, .mg)
        case .vitaminB2_riboflavin:
            return (1.3, .mg)
        case .vitaminB1_thiamine:
            return (1.2, .mg)
        case .caffeine:
            /// Source: https://www.hsph.harvard.edu/nutritionsource/caffeine/
            return (400, .mg)
        case .ethanol:
            return nil
        case .vitaminB9_folicAcid:
            return (400, .mcg)
        case .vitaminK2_menaquinone:
            /// https://futureyouhealth.com/knowledge-centre/vitamin-k2-benefits
            return (200, .mcg)
        case .taurine:
            return nil
        case .polyols:
            return nil
        case .gluten:
            /// https://www.coeliac.org.au/s/article/Gluten-Challenge
            return (10, .g)
        case .starch:
            /// https://healthyeating.sfgate.com/starchy-carbohydrate-limits-1318.html
            return (190, .g)
        case .salt:
            /// https://www.bhf.org.uk/informationsupport/support/healthy-living/healthy-eating/salt
            return (6, .g)
        default:
            return nil
        }
    }
    
    /**
     Converts a % RDA value to an amount
     */
    public func convertRDApercentage(_ percentage: Double) -> (amount: Double, NutrientUnit)? {
        guard let dailyValue = dailyValue else {
            return nil
        }
        return ((dailyValue.0) * percentage / 100.0, dailyValue.1)
    }
}

public extension NutrientType {
    func grams(equallingPercent percent: Double, of energy: Double) -> Double? {
        guard let kcalsPerGram else { return nil }
        guard percent >= 0, percent <= 100, energy > 0 else { return 0 }
        let energyPortion = energy * (percent / 100)
        return energyPortion / kcalsPerGram
    }
    
    var kcalsPerGram: Double? {
        switch self {
        case .saturatedFat, .monounsaturatedFat, .polyunsaturatedFat, .transFat:
            return KcalsPerGramOfFat
        case .sugars, .addedSugars:
            return KcalsPerGramOfCarb
        default:
            return nil
        }
    }

}
