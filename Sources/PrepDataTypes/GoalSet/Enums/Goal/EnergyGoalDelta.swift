import Foundation

public enum EnergyGoalDelta: Int16, Hashable, Codable, CaseIterable {
    case surplus
    case deficit
}

public extension EnergyGoalDelta {
    var description: String {
        switch self {
        case .deficit:  return "below maintenance"
        case .surplus:  return "above maintenance"
        }
    }
    
    var systemImage: String {
        switch self {
        case .deficit:  return "arrow.turn.right.down" // "minus.diamond"
        case .surplus:  return "arrow.turn.right.up" //"plus.diamond"
        }
    }
}
