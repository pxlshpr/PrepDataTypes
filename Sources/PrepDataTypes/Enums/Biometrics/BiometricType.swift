import Foundation

public enum BiometricType {
    case restingEnergy
    case activeEnergy
    case sex
    case age
    case weight
    case leanBodyMass
    case fatPercentage
    case height
    
    public var usesPrecision: Bool {
        switch self {
        case .weight, .leanBodyMass, .fatPercentage, .height:
            return true
        default:
            return false
        }
    }
    
    public var description: String {
        switch self {
        case .restingEnergy:
            return "Resting Energy"
        case .activeEnergy:
            return "Active Energy"
        case .sex:
            return "Sex"
        case .age:
            return "Age"
        case .weight:
            return "Weight"
        case .leanBodyMass:
            return "Lean Body Mass"
        case .fatPercentage:
            return "Fat Percentage"
        case .height:
            return "Height"
        }
    }

    public var usesUnit: Bool {
        switch self {
        case .sex, .age, .fatPercentage:
            return false
        default:
            return true
        }
    }
}
