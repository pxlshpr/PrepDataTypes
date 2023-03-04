#if os(iOS)
import SwiftUI

public enum NutrientMeterComponent: Codable {
    case energy
    case carb
    case fat
    case protein
    case micro(nutrientType: NutrientType, nutrientUnit: NutrientUnit)
}

//TODO: WTF is this?
extension NutrientMeterComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .energy:
            hasher.combine(0)
        case .carb:
            hasher.combine(1)
        case .fat:
            hasher.combine(2)
        case .protein:
            hasher.combine(3)
        case .micro(let name, let unit):
            hasher.combine(4)
            hasher.combine(name)
            hasher.combine(unit)
        }
    }
}

public extension NutrientMeterComponent {
    var iconImageName: String? {
        switch self {
        case .energy:
            return "flame.fill"
        default:
            return nil
        }
    }
    
    var initial: String {
        guard let firstCharacter = name.first else { return "" }
        return String(firstCharacter)
    }
        
    init(macro: Macro?) {
        guard let macro = macro else {
            self = .energy
            return
        }
        switch macro {
        case .carb:
            self = .carb
        case .fat:
            self = .fat
        case .protein:
            self = .protein
        }
    }
    
    var name: String {
        switch self {
        case .energy:
            //TODO: Handle kJ preference (return Kilojules or Energy)
            return "Calories"
        case .carb:
            return "Carb"
        case .fat:
            return "Fat"
        case .protein:
            return "Protein"
        case .micro(let nutrientType, _):
            return nutrientType.shortestDescription
        }
    }
    
    var fullDescription: String {
        switch self {
        case .energy:
            //TODO: Handle kJ preference (return Kilojules or Energy)
            return "Calories"
        case .carb:
            return "Carbohydrates"
        case .fat:
            return "Fat"
        case .protein:
            return "Protein"
        case .micro(let nutrientType, _):
            return nutrientType.description
        }
    }
    
    var unit: NutrientUnit {
        switch self {
        case .energy:
            //TODO: Handle kJ preference
            return .kcal
        case .micro(_, let nutrientUnit):
            return nutrientUnit
        default:
            return .g
        }
    }
}

extension NutrientMeterComponent: CustomStringConvertible {
    public var description: String {
        name
    }
}

extension Double {
    public var formattedWithCommas: String {
        guard self >= 1000 else {
            return cleanAmount
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: Int(self))
        
        guard let formatted = numberFormatter.string(from: number) else {
            return "\(Int(self))"
        }
        return formatted
    }
}

#endif

public extension NutrientType {
    var shortestDescription: String {
        
        if let letter = vitaminLetterName {
            return "Vit. \(letter)"
        }
        
        switch self {
        case .saturatedFat:
            return "Sat. Fat"
        case .monounsaturatedFat:
            return "MUFA"
        case .polyunsaturatedFat:
            return "PUFA"
        case .dietaryFiber:
            return "Fiber"
        case .potassium:
            return "Potass."
        default:
            return description
        }
    }
}

public extension NutrientUnit {
    
    /// Converts things like 1000 mg → 1g, 1000 ug → 1mg
    func convertingLargeValue(_ value: Double) -> (Double, NutrientUnit) {
        var value = value
        var unit = self
        
        if unit.isMicrograms, value >= 1000 {
            value = value / 1000.0
            unit = .mg
        }
        
        if unit.isMilligrams, value >= 1000 {
            value = value / 1000.0
            unit = .g
        }
            
        return (value, unit)
    }
    
    var isMilligrams: Bool {
        switch self {
        case .mg, .mgAT, .mgNE, .mgGAE:
            return true
        default:
            return false
        }
    }
    
    var isMicrograms: Bool {
        switch self {
        case .mcg, .mcgDFE, .mcgRAE:
            return true
        default:
            return false
        }
    }
    
    var shortestDescription: String {
        switch self {
        case .mgAT, .mgNE, .mgGAE:
            return "mg"
        case .mcg, .mcgDFE, .mcgRAE:
            return "μg"
        default:
            return shortDescription
        }
    }
}
