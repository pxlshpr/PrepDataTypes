import Foundation

public enum NutrientGoalType: Codable, Hashable {
    
    case fixed
    
    /// Only used with Diets
    case quantityPerBodyMass(BodyMassType, BodyMassUnit)
    case percentageOfEnergy
    case quantityPerEnergy(Double, EnergyUnit) /// `Double` indicates the value we're using

    /// Only used for meal profiles, for things like pre-workout meals
    case quantityPerWorkoutDuration(WorkoutDurationUnit)
}

public extension NutrientGoalType {
    
    func description(nutrientUnit: NutrientUnit, short: Bool = false) -> String {
        let per = short ? "/" : "per"
        switch self {
        case .fixed:
            return "\(nutrientUnit.shortDescription)"
        case .quantityPerBodyMass(_, let bodyMassUnit):
            return "\(nutrientUnit.shortDescription) \(per) \(bodyMassUnit.shortDescription)"
        case .percentageOfEnergy:
            return "%"
        case .quantityPerEnergy:
            return "\(nutrientUnit.shortDescription)"
        case .quantityPerWorkoutDuration(let workoutDurationUnit):
            return "\(nutrientUnit.shortDescription) \(per) \(short ? workoutDurationUnit.shortDescription : workoutDurationUnit.menuDescription)"
        }
    }
    
    func unitStrings(nutrientUnit: NutrientUnit) -> (String, String?) {
        let description = self.description(nutrientUnit: nutrientUnit, short: true)
        switch self {
        case .quantityPerBodyMass(let bodyMassType, _):
            return ("\(description) of", "\(bodyMassType.description)")
        case .percentageOfEnergy:
            return ("\(description) of", "energy goal")
        case .quantityPerEnergy(let double, let energyUnit):
            return ("\(description) per", "\(double.formattedEnergy) \(energyUnit.shortDescription)")
        case .quantityPerWorkoutDuration:
            return ("\(description)", "of exercise")
        default:
            return (description, nil)
        }
    }
    
    var accessoryDescription: String? {
        switch self {
        case .fixed:
            return nil
        case .percentageOfEnergy:
            return "of energy goal"
        case .quantityPerBodyMass(let bodyMass, _):
            return "of \(bodyMass.description)"
        case .quantityPerWorkoutDuration(_):
            return "of exercise"
        case .quantityPerEnergy(let energyValue, let energyUnit):
            return "per \(energyValue.cleanAmount) \(energyUnit.shortDescription)"
        }
    }
    
    var accessorySystemImage: String? {
        switch self {
        case .fixed:
            return nil
        case .percentageOfEnergy, .quantityPerEnergy:
            return nil
//            return "flame.fill"
        case .quantityPerBodyMass(_, _):
            return nil
//            return "figure.arms.open"
        case .quantityPerWorkoutDuration(_):
            return nil
//            return "stopwatch.fill"
        }
    }
    
    var usesWeight: Bool {
        switch self {
        case .quantityPerBodyMass:
            return true
        default:
            return false
        }
    }
    
    var isPercentageOfEnergy: Bool {
        switch self {
        case .percentageOfEnergy:
            return true
        default:
            return false
        }
    }
    
    var isQuantityPerWorkoutDuration: Bool {
        switch self {
        case .quantityPerWorkoutDuration:
            return true
        default:
            return false
        }
    }
    
    var isQuantityPerEnergy: Bool {
        switch self {
        case .quantityPerEnergy:
            return true
        default:
            return false
        }
    }
    
    var dependsOnEnergy: Bool {
        switch self {
        case .percentageOfEnergy, .quantityPerEnergy:
            return true
        default:
            return false
        }
    }
    
    var isQuantityPerBodyMass: Bool {
        switch self {
        case .quantityPerBodyMass:
            return true
        default:
            return false
        }
    }
    
    var isFixedQuantity: Bool {
        switch self {
        case .fixed:
            return true
        default:
            return false
        }
    }

}

public extension NutrientGoalType {
    var bodyMassType: BodyMassType? {
        get {
            switch self {
            case .quantityPerBodyMass(let bodyMassType, _):
                return bodyMassType
            default:
                return nil
            }
        }
        set {
            guard let newValue else { return }
            switch self {
            case .quantityPerBodyMass(_, let bodyMassUnit):
                self = .quantityPerBodyMass(newValue, bodyMassUnit)
            default:
                break
            }
        }
    }
    
    var bodyMassUnit: BodyMassUnit? {
        get {
            switch self {
            case .quantityPerBodyMass(_, let bodyMassUnit):
                return bodyMassUnit
            default:
                return nil
            }
        }
        set {
            guard let newValue else { return }
            switch self {
            case .quantityPerBodyMass(let bodyMassType, _):
                self = .quantityPerBodyMass(bodyMassType, newValue)
            default:
                break
            }
        }
    }
    
    var workoutDurationUnit: WorkoutDurationUnit? {
        switch self {
        case .quantityPerWorkoutDuration(let unit):
            return unit
        default:
            return nil
        }
    }
    
    var perEnergyValue: Double? {
        switch self {
        case .quantityPerEnergy(let value, _):
            return value
        default:
            return nil
        }
    }
}
