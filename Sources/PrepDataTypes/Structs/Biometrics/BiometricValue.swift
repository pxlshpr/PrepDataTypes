import Foundation

public extension FloatingPoint {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}

public enum BiometricValue: Equatable {
    
    case activeEnergy(Double, EnergyUnit)
    case restingEnergy(Double, EnergyUnit)
    case sex(BiometricSex)
    case age(Int)
    case weight(Double, BodyMassUnit)
    case leanBodyMass(Double, BodyMassUnit)
    case height(Double, HeightUnit)
    case fatPercentage(Double)
    
    public var primaryDouble: Double? {
        switch unit {
        case .height(let heightUnit):
            if heightUnit == .ft, let double {
                return double.whole
            } else {
                return double
            }

        case .bodyMass(let bodyMassUnit):
            if bodyMassUnit == .st, let double {
                return double.whole
            } else {
                return double
            }
            
        default:
            return double
        }
    }

    public var secondaryDouble: Double? {
        switch unit {
        case .height(let heightUnit):
            if heightUnit == .ft, let double {
                return double.fraction * InchesPerFoot
            } else {
                return double
            }

        case .bodyMass(let bodyMassUnit):
            if bodyMassUnit == .st, let double {
                return double.fraction * PoundsPerStone
            } else {
                return double
            }
            
        default:
            return double
        }
    }

    public var double: Double? {
        get {
            switch self {
            case .activeEnergy(let double, _):
                return double
            case .restingEnergy(let double, _):
                return double
            case .weight(let double, _):
                return double
            case .leanBodyMass(let double, _):
                return double
            case .height(let double, _):
                return double
            case .fatPercentage(let double):
                return double
            case .age(let int):
                return Double(int)
            default:
                return nil
            }
        }
        set {
            guard let newValue else { return }
            switch self {
            case .activeEnergy(_, let energyUnit):
                self = .activeEnergy(newValue, energyUnit)
            case .restingEnergy(_, let energyUnit):
                self = .restingEnergy(newValue, energyUnit)
            case .weight(_, let bodyMassUnit):
                self = .weight(newValue, bodyMassUnit)
            case .leanBodyMass(_, let bodyMassUnit):
                self = .leanBodyMass(newValue, bodyMassUnit)
            case .height(_, let heightUnit):
                self = .height(newValue, heightUnit)
            case .fatPercentage:
                self = .fatPercentage(newValue)
            case .age:
                self = .age(Int(newValue))
            default:
                break
            }
        }
    }
    
    public var unit: BiometricUnit? {
        switch self {
        case .activeEnergy(_, let energyUnit):
            return .energy(energyUnit)
        case .restingEnergy(_, let energyUnit):
            return .energy(energyUnit)
        case .weight(_, let bodyMassUnit):
            return .bodyMass(bodyMassUnit)
        case .leanBodyMass(_, let bodyMassUnit):
            return .bodyMass(bodyMassUnit)
        case .height(_, let heightUnit):
            return .height(heightUnit)
        case .fatPercentage:
            return .percentage
        case .age:
            return .years
        case .sex:
            return nil
        }
    }
    
    public var type: BiometricType {
        switch self {
        case .activeEnergy:
            return .activeEnergy
        case .restingEnergy:
            return .restingEnergy
        case .sex:
            return .sex
        case .age:
            return .age
        case .weight:
            return .weight
        case .leanBodyMass:
            return .leanBodyMass
        case .height:
            return .height
        case .fatPercentage:
            return .fatPercentage
        }
    }
    
    public var age: Int? {
        switch self {
        case .age(let int):
            return int
        default:
            return nil
        }
    }
    
    public var sex: BiometricSex? {
        switch self {
        case .sex(let biometricSex):
            return biometricSex
        default:
            return nil
        }
    }

    public var valueDescription: String {
        switch self {
        case .activeEnergy(let double, _):
            return double.formattedEnergy
        case .restingEnergy(let double, _):
            return double.formattedEnergy
            
        case .sex(let biometricSex):
            return biometricSex.description
        case .age(let int):
            return String(int)

        case .fatPercentage(let double):
            return double.cleanAmount

        case .weight, .leanBodyMass, .height:
            return usesSecondaryUnit
            ? primaryDouble?.formattedEnergy ?? ""
            : primaryDouble?.string(withDecimalPlaces: 1) ?? ""
        }
    }
    
    public var usesSecondaryUnit: Bool {
        secondaryUnitDescription != nil
    }
    
    public var secondaryValueDescription: String? {
        guard let secondaryDouble else { return nil }
//        return secondaryDouble.formattedEnergy
        return secondaryDouble.string(withDecimalPlaces: 1)
    }
    
    public var unitDescription: String? {
        switch self {
        case .activeEnergy(_, let energyUnit):
            return energyUnit.shortDescription
        case .restingEnergy(_, let energyUnit):
            return energyUnit.shortDescription
        case .sex:
            return nil
        case .age:
            return "years"
        case .weight(_, let bodyMassUnit):
            return bodyMassUnit.shortDescription
        case .leanBodyMass(_, let bodyMassUnit):
            return bodyMassUnit.shortDescription
        case .height(_, let heightUnit):
            return heightUnit.shortDescription
        case .fatPercentage:
            return "%"
        }
    }
    
    public var secondaryUnitDescription: String? {
        guard let unit else { return nil }
        switch unit {
        case .bodyMass(let bodyMassUnit):
            return bodyMassUnit == .st ? "lb" : nil
        case .height(let heightUnit):
            return heightUnit == .ft ? "in" : nil
        default:
            return nil
        }
    }
}

extension Double {
    func string(withDecimalPlaces places: Int) -> String {
        let rounded = self.rounded(toPlaces: places)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = NSNumber(value: rounded)
        
        guard let formatted = numberFormatter.string(from: number) else {
            return "\(rounded)"
        }
        return formatted
    }
}
