import Foundation

public enum BodyMassType: Int16, Hashable, Codable, CaseIterable, Identifiable {
    case weight = 1
    case leanMass
    
    public var id: Int16 { rawValue }
    
    public var description: String {
        switch self {
        case .weight:
            return "body weight"
        case .leanMass:
            return "lean body mass"
        }
    }
    
    public var pickerDescription: String {
        switch self {
        case .weight:
            return "body weight"
        case .leanMass:
            return "lean body mass"
        }
    }
    
    public var pickerPrefix: String {
        "of "
    }
    
    public var menuDescription: String {
        switch self {
        case .weight:
            return "body weight"
        case .leanMass:
            return "lean body mass"
        }
    }
}
