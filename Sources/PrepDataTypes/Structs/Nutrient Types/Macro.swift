public enum Macro: String, CaseIterable, Codable {
    case carb = "Carbohydrate"
    case fat = "Fat"
    case protein = "Protein"
}

public extension Macro {
    
    var multiplier: Double {
        switch self {
        case .carb: return 4
        case .fat: return 9
        case .protein: return 4
        }
    }
    
    var initial: String {
        switch self {
        case .carb: return "C"
        case .fat: return "F"
        case .protein: return "P"
        }
    }
}

extension Macro: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

#if os(iOS)
import SwiftUI
import SwiftSugar

import ColorSugar

public extension Macro {

    func fillColor(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .carb:
            return colorScheme == .light
            ? Color(hex: "FFB02A")
            : Color(hex: "FFCD34")
        case .fat:
            return colorScheme == .light
            ? Color(hex: "B900FF")
            : Color(hex: "DF00FF")
        case .protein:
            return colorScheme == .light
            ? Color(hex: "47ACB1")
            : Color(hex: "47ACB1")
        }
    }

    func textColor(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .carb:
            return colorScheme == .light
            ? Color(hex: "CA7700")
            : Color(hex: "FFCD34")
        case .fat:
            return colorScheme == .light
            ? Color(hex: "B900FF")
            : Color(hex: "E742FF")
        case .protein:
            return colorScheme == .light
            ? Color(hex: "3D969A")
            : Color(hex: "9AFBFF")
        }
    }
    
    //TODO: Document these so we can use them easily
    var color: Color {
        Color(uiColor)
    }
    
    var labelColor: Color {
        Color(labelUiColor)
    }

    var nutrientMealBackgroundColor: Color {
        Color(UIColor(named: "Nutrient\(rawValue)Bg") ?? .label)
    }

    var nutrientMealUnitColor: Color {
        Color(UIColor(named: "Nutrient\(rawValue)Unit") ?? .label)
    }

    var uiColor: UIColor {
        UIColor(named: rawValue) ?? .label
    }
    
    var labelUiColor: UIColor {
        UIColor(named: "\(rawValue)-Label") ?? .label
    }
}
#endif

public extension Macro {
    
    func grams(equallingPercent percent: Double, of energy: Double) -> Double {
        guard percent >= 0, percent <= 100, energy > 0 else { return 0 }
        let energyPortion = energy * (percent / 100)
        return energyPortion / kcalsPerGram
    }
    
    var kcalsPerGram: Double {
        switch self {
        case .carb:
            return KcalsPerGramOfCarb
        case .fat:
            return KcalsPerGramOfFat
        case .protein:
            return KcalsPerGramOfProtein
        }
    }
}

public extension Macro {
    var minimumValueForAutoGoals: Double {
        switch self {
        case .carb:
            return 10
        case .fat:
            return 5
        case .protein:
            return 10
        }
    }
}
