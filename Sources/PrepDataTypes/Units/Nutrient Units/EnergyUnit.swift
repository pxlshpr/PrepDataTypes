import Foundation

public enum EnergyUnit: Int16, CaseIterable, Codable {
    case kcal = 1
    case kJ
}

extension EnergyUnit: DescribableUnit {
    public var description: String {
        switch self {
        case .kcal:
            return "Kilocalorie"
        case .kJ:
            return "Kilojule"
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .kcal:
            return "kcal"
        case .kJ:
            return "kJ"
        }
    }
    
    public func title(isPlural: Bool) -> String {
        description
    }
}

public extension EnergyUnit {
    /**
     1 kcal = 4.184 kJ
     */
    static func convertToKilocalories(fromKilojules kJ: Double) -> Double {
        kJ / 4.184
    }
    
    static func convertToKilojules(fromKilocalories kcal: Double) -> Double {
        kcal * 4.184
    }
}
