import SwiftSugar

public enum VolumeUnit: Int16, CaseIterable, Codable {
    case gallon = 1
    case quart
    case pint
    case cup
    case fluidOunce
    case tablespoon
    case teaspoon
    case mL
    case liter
}

public extension VolumeUnit {
    static var settingsOptions: [VolumeUnit] {
        [.cup, .teaspoon, .tablespoon, .fluidOunce, .pint, .quart, .gallon]
    }
}

extension VolumeUnit: DescribableUnit {
    public var description: String {
        switch self {
        case .gallon:
            return "Gallon"
        case .quart:
            return "Quart"
        case .pint:
            return "Pint"
        case .cup:
            return "Cup"
        case .fluidOunce:
            return "Fluid Ounce"
        case .tablespoon:
            return "Tablespoon"
        case .teaspoon:
            return "Teaspoon"
        case .mL:
            return "Millilitre"
        case .liter:
            return "Litre"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .gallon:
            return "gal"
        case .quart:
            return "qt"
        case .pint:
            return "pt"
        case .cup:
            return "cup"
        case .fluidOunce:
            return "fl oz"
        case .tablespoon:
            return "tbsp"
        case .teaspoon:
            return "tsp"
        case .mL:
            return "mL"
        case .liter:
            return "L"
        }
    }
    
    public var regex: String {
        switch self {
        case .gallon:
            return #"^g"#
        case .quart:
            return #"^q"#
        case .pint:
            return #"^p"#
        case .cup:
            return #"^c"#
        case .fluidOunce:
            return #"^(fl|oz)"#
        case .tablespoon:
            return #"^(tb|tab)"#
        case .teaspoon:
            return #"^(ts|tea)"#
        case .mL:
            return #"^(ml|mil)"#
        case .liter:
            return #"^l"#
        }
    }
    
    public init?(string: String) {
        for unit in Self.allCases {
            if string.matchesRegex(unit.regex) {
                self = unit
                return
            }
        }
        return nil
    }
}
