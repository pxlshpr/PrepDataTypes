import Foundation

public enum NutrientTypeGroup: Int16, CaseIterable, Codable {
    case fats = 1
    case fibers
    case sugars
    case minerals
    case vitamins
    case misc
    
    public var description: String {
        switch self {
        case .fats:
            return "Fats"
        case .fibers:
            return "Fibers"
        case .sugars:
            return "Sugars"
        case .minerals:
            return "Minerals"
        case .vitamins:
            return "Vitamins"
        case .misc:
            return "Miscellaneous"
        }
    }
}
