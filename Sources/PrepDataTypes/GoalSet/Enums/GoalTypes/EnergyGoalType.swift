import Foundation

public enum EnergyGoalType: Hashable, Codable {
    case fixed(EnergyUnit)
    
    /// Only used with diets
    case fromMaintenance(EnergyUnit, EnergyGoalDelta)
    case percentFromMaintenance(EnergyGoalDelta)
}

public extension EnergyGoalType {
    
    var isFixed: Bool {
        switch self {
        case .fixed:
            return true
        default:
            return false
        }
    }
    
    var description: String {
        switch self {
        case .fixed(let energyUnit):
            return energyUnit.shortDescription
        case .fromMaintenance(let energyUnit, _):
            return energyUnit.shortDescription
        case .percentFromMaintenance:
            return "%"
        }
    }
    
    var systemImage: String {
        switch self {
        case .fixed, .fromMaintenance:
            return "flame"
        case .percentFromMaintenance:
            return "percent"
        }
    }
    
    var accessoryDescription: String? {
        switch self {
        case .fixed:
            return nil
        case .fromMaintenance(_, let delta):
            return delta.description
        case .percentFromMaintenance(let delta):
            return delta.description
        }
    }
    
    var accessorySystemImage: String? {
        switch self {
        case .fixed:
            return nil
        case .fromMaintenance(_, let delta):
            return delta.systemImage
        case .percentFromMaintenance(let delta):
            return delta.systemImage
        }
    }
    
    var delta: EnergyGoalDelta? {
        switch self {
        case .fromMaintenance(_, let energyDelta):
            return energyDelta
        case .percentFromMaintenance(let energyDelta):
            return energyDelta
        default:
            return nil
        }
    }
    
    var unitStrings: (String, String?) {
        switch self {
        case .fixed(let unit):
            return (unit.shortDescription, nil)
        case .fromMaintenance(let unit, let delta):
            return ("\(unit.shortDescription) \(delta.shortDescription)", "maintenance")
        case .percentFromMaintenance(let delta):
            return ("% \(delta.shortDescription)", "maintenance")
        }
    }
}
