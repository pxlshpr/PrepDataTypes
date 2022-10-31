import Foundation

public enum WeightUnit: Int16, CaseIterable, Codable {
    case g = 1
    case kg
    case oz
    case lb
    case mg
}

public extension WeightUnit {
    var g: Double {
        switch self {
        case .g:
            return 1
        case .kg:
            return 1000
        case .oz:
            return 28.349523
        case .lb:
            return 453.59237
        case .mg:
            return 0.001
        }
    }
    
    var regex: String {
        switch self {
        case .g:
            return #"^(g raw weight|gramm|gram|gr|gm|g)"#
        case .kg:
            return #"^kg"#
        case .mg:
            return #"^mg"#
        case .oz:
            return #"^(wt. oz|ounce|oz)"#
        case .lb:
            return #"(pound|lb)"#
        }
    }
}

extension WeightUnit: DescribableUnit {
    public var description: String {
        switch self {
        case .g:
            return "Gram"
        case .kg:
            return "Kilogram"
        case .oz:
            return "Ounce"
        case .lb:
            return "Pound"
        case .mg:
            return "Milligram"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .g:
            return "g"
        case .kg:
            return "kg"
        case .oz:
            return "oz"
        case .lb:
            return "lb"
        case .mg:
            return "mg"
        }
    }
}
