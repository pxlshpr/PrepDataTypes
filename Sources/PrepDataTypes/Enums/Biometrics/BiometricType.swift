import Foundation

public enum BiometricType: CaseIterable {
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
    
    public var shortDescription: String {
        switch self {
        case .restingEnergy:
            return "resting energy"
        case .activeEnergy:
            return "active energy"
        case .sex:
            return "sex"
        case .age:
            return "age"
        case .weight:
            return "weight"
        case .leanBodyMass:
            return "lean body mass"
        case .fatPercentage:
            return "fat %"
        case .height:
            return "height"
        }
    }
    
    public var description: String {
        switch self {
        case .restingEnergy:
            return "Resting Energy"
        case .activeEnergy:
            return "Active Energy"
        case .sex:
            return "Biological Sex"
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
    
    public var systemImage: String? {
        switch self {
        case .restingEnergy:
            return "bed.double.fill"
        case .activeEnergy:
            return "figure.walk.motion"
        default:
            return nil
        }
    }
}
