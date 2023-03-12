import Foundation

public enum BiometricUnit {
    case energy(EnergyUnit)
    case bodyMass(BodyMassUnit)
    case height(HeightUnit)
    case years
    case percentage
    
    public var description: String {
        switch self {
        case .energy(let energyUnit):
            return energyUnit.shortDescription
        case .bodyMass(let bodyMassUnit):
            return bodyMassUnit.shortDescription
        case .height(let heightUnit):
            return heightUnit.shortDescription
        case .years:
            return "years"
        case .percentage:
            return "%"
        }
    }
    
    public var energyUnit: EnergyUnit? {
        switch self {
        case .energy(let energyUnit):
            return energyUnit
        default:
            return nil
        }
    }
    public var bodyMassUnit: BodyMassUnit? {
        switch self {
        case .bodyMass(let bodyMassUnit):
            return bodyMassUnit
        default:
            return nil
        }
    }
    public var heightUnit: HeightUnit? {
        switch self {
        case .height(let heightUnit):
            return heightUnit
        default:
            return nil
        }
    }
    
    public var hasTwoComponents: Bool {
        switch self {
        case .bodyMass(let bodyMassUnit):
            return bodyMassUnit == .st
        case .height(let heightUnit):
            return heightUnit == .ft
        default:
            return false
        }
    }
}
