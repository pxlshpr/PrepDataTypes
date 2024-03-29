import Foundation

public enum NutrientUnit: Int16, CaseIterable, Codable {
    case g = 1
    case mg
    case mgAT /// alpha-tocopherol
    case mgNE
    case mcg = 50
    case mcgDFE
    case mcgRAE
    case IU = 100
    case p /// percent
    case kcal = 200
    case kJ
    
    /// Used by USDA
    case pH = 300
    case SG
    case mcmolTE
    case mgGAE
}

public extension NutrientUnit {
    //TODO: Write tests for these
    func convert(_ amount: Double, to unit: FoodLabelUnit) -> Double {
        var scale: Double {
            switch self {
            case .g:
                switch unit {
                case .mcg:
                    return 1000000
                case .mg:
                    return 1000
                case .oz:
                    return 0.035274
                case .g:
                    return 1
                default:
                    return 0
                }
            case .mg, .mgAT, .mgNE, .mgGAE:
                switch unit {
                case .mcg:
                    return 1000
                case .mg:
                    return 1
                case .oz:
                    return 0.00003527
                case .g:
                    return 0.001
                default:
                    return 0
                }
            case .mcg, .mcgDFE, .mcgRAE:
                switch unit {
                case .mcg:
                    return 1
                case .mg:
                    return 0.001
                case .oz:
                    return 0.000000035274
                case .g:
                    return 0.000001
                default:
                    return 0
                }
            case .kcal:
                switch unit {
                case .kj:
                    return KjPerKcal
                default:
                    return 0
                }
            case .kJ:
                switch unit {
                case .kcal:
                    return 1.0/KjPerKcal
                default:
                    return 0
                }
            case .IU:
                //TODO: Handle this
                return 0
            default:
                return 0
            }
        }
        
        return amount * scale
    }
}

extension NutrientUnit: DescribableUnit {
    public var description: String {
        switch self {
        case .g:
            return "grams"
        case .mg:
            return "milligrams"
        case .mgAT:
            return "milligrams of alpha-tocopherol"
        case .mgNE:
            return "milligrams of niacin equivalents"
        case .mcg:
            return "micrograms"
        case .mcgDFE:
            return "micrograms of dietary folate equivalents"
        case .mcgRAE:
            return "micrograms of retinol activity equivalents"
        case .IU:
            return "international units"
        case .p:
            return "percentage"
        case .kcal:
            return "kilocalories"
        case .kJ:
            return "kilojules"
        case .pH:
            return "potential of hydrogen"
        case .SG:
            return "specific gravity"
        case .mcmolTE:
            return "antioxidant activity"
        case .mgGAE:
            return "total phenolic content"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .g:
            return "g"
        case .mg:
            return "mg"
        case .mgAT:
            return "mg"
        case .mgNE:
            return "mg NE"
        case .mcg:
            return "mcg"
        case .mcgDFE:
            return "mcg DFE"
        case .mcgRAE:
            return "mcg RAE"
        case .IU:
            return "IU"
        case .p:
            return "%"
        case .kcal:
            return "kcal"
        case .kJ:
            return "kJ"
        case .pH:
            return "pH"
        case .SG:
            return "SG"
        case .mcmolTE:
            return "mcmol TE"
        case .mgGAE:
            return "mg GAE"
        }
    }
    
    public func title(isPlural: Bool) -> String {
        description
    }
}

public extension NutrientUnit {
    var foodLabelUnit: FoodLabelUnit? {
        switch self {
        case .g:
            return .g
        case .mcg, .mcgDFE, .mcgRAE:
            return .mcg
        case .mg, .mgAT, .mgNE:
            return .mg
        case .p:
            return .p
        case .IU:
//            return .iu
            return nil
        case .kcal:
            return .kcal
        case .kJ:
            return .kj
                        
        /// Used by the USDA Database
        case .pH, .SG, .mcmolTE, .mgGAE:
            return nil
        }
    }
}
