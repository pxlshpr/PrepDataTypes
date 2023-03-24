import Foundation

public enum GoalRequirement {
    case maintenanceEnergy
    case leanMass
    case weight
    case energyGoal
    case workoutDuration
    
    public var message: String {
        switch self {
        case .maintenanceEnergy:
            return "Set Maintenance Energy"
        case .leanMass:
            return "Set Lean Body Mass"
        case .weight:
            return "Set Weight"
        case .energyGoal:
            return "Set Energy Goal"
        case .workoutDuration:
            return "Calculated when used"
        }
    }
    
    public var description: String {
        switch self {
        case .maintenanceEnergy:
            return "maintenance"
        case .leanMass:
            return "lean body mass"
        case .weight:
            return "body weight"
        case .energyGoal:
            return "energy goal"
        case .workoutDuration:
//            return "workout duration"
            return "exercise"
        }
    }
    
    public var isBiometric: Bool {
        self != .workoutDuration
    }
    
    public var systemImage: String {
        switch self {
        case .maintenanceEnergy:
            return "flame.fill"
        case .leanMass, .weight:
            return "figure.arms.open"
        case .energyGoal:
            return "flame.fill"
        case .workoutDuration:
            return "figure.run"
        }
    }
}

extension GoalType {
    public var requirement: GoalRequirement? {
        switch self {
        case .energy(let energyGoalType):
            switch energyGoalType {
            case .fromMaintenance, .percentFromMaintenance:
                return .maintenanceEnergy
            default:
                return nil
            }
        default:
            guard let nutrientGoalType else { return nil }
            switch nutrientGoalType {
            case .percentageOfEnergy, .quantityPerEnergy:
                return .energyGoal
            case .quantityPerWorkoutDuration:
                return .workoutDuration
            case .quantityPerBodyMass(let bodyMassType, _):
                switch bodyMassType {
                case .leanMass:
                    return .leanMass
                case .weight:
                    return .weight
                }
            default:
                return nil
            }
        }
    }
}
