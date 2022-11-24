import Foundation

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
