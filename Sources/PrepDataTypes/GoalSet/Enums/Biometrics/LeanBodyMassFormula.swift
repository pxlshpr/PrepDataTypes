import Foundation

public enum LeanBodyMassFormula: Int16, Codable, CaseIterable {
    case boer = 1
    case james
    case hume
    
    public var pickerDescription: String {
        switch self {
        case .boer:
            return "Boer • 1984"
        case .james:
            return "James • 1976"
        case .hume:
            return "Hume • 1966"
        }
    }
    
    public var year: String {
        switch self {
        case .boer:
            return "1984"
        case .james:
            return "1976"
        case .hume:
            return "1966"
        }
    }
    
    public var menuDescription: String {
        switch self {
        case .boer:
            return "Boer"
        case .james:
            return "James"
        case .hume:
            return "Hume"
        }
    }
    
    /// Formulas taken from: [here](https://www.calculator.net/lean-body-mass-calculator.html)
    public func calculate(sexIsFemale: Bool, weightInKg weight: Double, heightInCm height: Double) -> Double {
        guard weight > 0, height > 0 else { return 0 }
        let lbm: Double
        switch sexIsFemale {
        case true:
            /// female
            switch self {
            case .boer:
                lbm = (0.252 * weight) + (0.473 * height) - 48.3
            case .james:
                lbm = (1.07 * weight) - (148.0 * pow((weight/height), 2.0))
            case .hume:
                lbm = (0.29569 * weight) + (0.41813 * height) - 43.2933
            }
        case false:
            /// male
            switch self {
            case .boer:
                lbm = (0.407 * weight) + (0.267 * height) - 19.2
            case .james:
                lbm = (1.1 * weight) - (128.0 * pow((weight/height), 2.0))
            case .hume:
                lbm = (0.32810 * weight) + (0.33929 * height) - 29.5336
            }
        }
        return max(lbm, 0)
    }
}
