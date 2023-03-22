import Foundation

public let PoundsPerStone: Double = 14

public enum BodyMassUnit: Int16, CaseIterable, Codable, Identifiable {
    case kg = 1
    case lb
    case st
    
    public var shortDescription: String {
        switch self {
        case .kg:
            return "kg"
        case .lb:
            return "lb"
        case .st:
            return "st"
        }
    }
    
    public var id: Int16 { rawValue }
}

public extension BodyMassUnit {
    var g: Double {
        switch self {
        case .kg:
            return 1000
        case .lb:
            return 453.59237
        case .st:
            return 6350.29318
        }
    }
    func convert(_ value: Double, to other: BodyMassUnit) -> Double {
        let inGrams = value * self.g
        return inGrams / other.g
    }
}

public extension BodyMassUnit {
    var menuDescription: String {
        switch self {
        case .kg:
            return "kilogram"
        case .lb:
            return "pound"
        case .st:
            return "stone"
        }
    }
    
    var pickerDescription: String {
        switch self {
        case .kg:
            return "kilogram"
        case .lb:
            return "pound"
        case .st:
            return "stone"
        }
    }
    
    var pickerPrefix: String {
        "per "
    }
}


#if os(iOS)
import HealthKit

public extension BodyMassUnit {
    var healthKitUnit: HKUnit {
        switch self {
        case .kg:
            return .gramUnit(with: .kilo)
        case .lb:
            return .pound()
        case .st:
            return .stone()
        }
    }
}
#endif

//MARK: - Weight

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

public extension WeightUnit {
    func convert(_ value: Double, to other: WeightUnit) -> Double {
        let inGrams = value * self.g
        return inGrams / other.g
    }
}
