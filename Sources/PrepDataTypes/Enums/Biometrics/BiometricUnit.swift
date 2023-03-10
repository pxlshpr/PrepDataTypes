import Foundation

public enum BiometricUnit {
    case energy(EnergyUnit)
    case weight(WeightUnit)
    case height(HeightUnit)
    
    public var description: String {
        switch self {
        case .energy(let energyUnit):
            return energyUnit.shortDescription
        case .weight(let weightUnit):
            return weightUnit.shortDescription
        case .height(let heightUnit):
            return heightUnit.shortDescription
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
    public var weightUnit: WeightUnit? {
        switch self {
        case .weight(let weightUnit):
            return weightUnit
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
}
