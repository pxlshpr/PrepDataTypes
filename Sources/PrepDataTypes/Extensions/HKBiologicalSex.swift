#if os(iOS)
import HealthKit

public extension HKBiologicalSex {
    var description: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .other:
            return "Other"
        case .notSet:
            return "Not Set"
        default:
            return "Unknown"
        }
    }
}
#endif
