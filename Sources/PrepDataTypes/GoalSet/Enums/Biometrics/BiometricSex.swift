import Foundation

public enum BiometricSex: Int16, Codable, CaseIterable {
    case female = 1
    case male
    case other
    
    public var description: String {
        switch self {
        case .female:
            return "female"
        case .male:
            return "male"
        case .other:
            return "other"
        }
    }
}

#if os(iOS)
import HealthKit

public extension BiometricSex {
    var hkBiologicalSex: HKBiologicalSex {
        switch self {
        case .female:
            return .female
        case .male:
            return .male
        case .other:
            return .other
        }
    }
}

public extension HKBiologicalSex {
    var biometricSex: BiometricSex {
        switch self {
        case .female:
            return .female
        case .male:
            return .male
        default:
            return .other
        }
    }
}

#endif
