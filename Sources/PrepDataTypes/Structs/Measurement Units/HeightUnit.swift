import Foundation

public let InchesPerFoot: Double = 12

public enum HeightUnit: Int, CaseIterable, Codable {
    case cm = 1
    case ft
    case m
}

public extension HeightUnit {
    var description: String {
        switch self {
        case .m:
            return "meters"
        case .cm:
            return "centimeters"
        case .ft:
            return "feet"
        }
    }
    
    var shortDescription: String {
        switch self {
        case .cm:
            return "cm"
        case .ft:
            return "ft"
        case .m:
            return "m"
        }
    }
}

public extension HeightUnit {
    var cm: Double {
        switch self {
        case .cm:
            return 1
        case .ft:
            return 30.48
        case .m:
            return 100
        }
    }
    
    func convert(_ value: Double, to other: HeightUnit) -> Double {
        let inCm = value * self.cm
        return inCm / other.cm
    }
}

#if os(iOS)
import HealthKit

public extension HeightUnit {
    
    var healthKitUnit: HKUnit {
        switch self {
        case .cm:
            return .meterUnit(with: .centi)
        case .ft:
            return .foot()
        case .m:
            return .meter()
        }
    }
}

#endif
