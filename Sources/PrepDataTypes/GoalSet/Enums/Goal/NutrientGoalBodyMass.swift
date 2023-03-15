import Foundation

public enum NutrientGoalBodyMassType: Int16, Hashable, Codable, CaseIterable {
    case weight = 1
    case leanMass
}

public extension NutrientGoalBodyMassType {
    
    var description: String {
        switch self {
        case .weight:
            return "weight"
        case .leanMass:
            return "lean body mass"
        }
    }
    
    var pickerDescription: String {
        switch self {
        case .weight:
            return "weight"
        case .leanMass:
            return "lean body mass"
        }
    }
    
    var pickerPrefix: String {
        "of "
    }
    
    var  menuDescription: String {
        switch self {
        case .weight:
            return "weight"
        case .leanMass:
            return "lean body mass"
        }
    }
}
