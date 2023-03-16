import Foundation

public enum EnergyGoalDelta: Int16, Hashable, Codable, CaseIterable {
    case surplus
    case deficit
    case deviation
}

public extension EnergyGoalDelta {
    var description: String {
        switch self {
        case .deficit:      return "below maintenance"
        case .surplus:      return "above maintenance"
        case .deviation:    return "around maintenance"
        }
    }
    
    var systemImage: String {
        switch self {
        case .deficit:      return "arrow.turn.right.down"
        case .surplus:      return "arrow.turn.right.up"
        case .deviation:    return "arrow.left.and.right"
        }
    }
}
