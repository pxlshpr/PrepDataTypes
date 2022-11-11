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


public extension NutrientType {
    func matchesSearchString(_ string: String) -> Bool {
        description.lowercased().contains(string.lowercased())
    }
}

public extension NutrientTypeGroup {
    var nutrients: [NutrientType] {
        NutrientType.allCases.filter({ $0.group == self })
    }
}

extension NutrientType: Identifiable {
    public var id: Int16 {
        return rawValue
    }
}

extension NutrientTypeGroup: Identifiable {
    public var id: Int16 {
        return rawValue
    }
}
