import SwiftUI

public enum GoalMacroType: Int16, Codable, CaseIterable {
    case absolute = 1
    case ratioLeanMass
    case ratioBodyWeight
    case percentage
}

extension GoalMacroType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .absolute: return "g"
        case .ratioLeanMass: return "g / kg (lean mass)"
        case .ratioBodyWeight: return "g / kg (bodyweight)"
        case .percentage: return "% (energy)"
        }
    }
}

public extension GoalMacroType {
    var firstLine: String {
        switch self {
        case .absolute: return "g"
        case .ratioLeanMass: return "g / kg"
        case .ratioBodyWeight: return "g / kg"
        case .percentage: return "% of"
        }
    }
    
    var secondLine: String {
        switch self {
        case .absolute: return ""
        case .ratioLeanMass: return "lean mass"
        case .ratioBodyWeight: return "bodyweight"
        case .percentage: return "energy"
        }
    }
    
    static var all: [String] {
        allCases.map { $0.description }
    }
    
    static var allButPercent: [String] {
        var all = allCases
        all.removeAll(where: {$0 == .percentage})
        return all.map { $0.description }
    }
    
}


public extension GoalMacroType {
    
    
    func parameterValue(from macroValue: Double, leanMass: Double? = nil, weight: Double? = nil, energy: CGFloat? = nil, macro: Macro? = nil) -> Double? {
        
        var leanMassRatio: Double? {
            guard let leanMass = leanMass else { return nil }
            return macroValue / leanMass
        }
        
        var bodyweightRatio: Double? {
            guard let weight = weight else { return nil }
            return macroValue / weight
        }
        
        func percentage(from value: Double) -> Double? {
            guard let macro = macro, let energy = energy, energy != 0 else { return nil }
            return ((value * macro.multiplier) / Double(energy) * 100)
        }
        
        switch self {
        case .absolute: return macroValue
        case .ratioLeanMass: return leanMassRatio
        case .ratioBodyWeight: return bodyweightRatio
        case .percentage: return percentage(from: macroValue)
        }
    }
    
    func macroValue(from parameterValue: Double?, leanMass: Double? = nil, weight: Double? = nil, energy: CGFloat? = nil, macro: Macro? = nil) -> Double? {
        
        guard let parameterValue = parameterValue else { return nil }
        var valueFromLeanMassRatio: Double? {
            guard let leanMass = leanMass else { return nil }
            return parameterValue * leanMass
        }
        
        var valueFromBodyweightRatio: Double? {
            guard let weight = weight else { return nil }
            return parameterValue * weight
        }
        
        func valueFromPercentage(_ percentage: Double) -> Double? {
            guard let macro = macro, let energy = energy, energy != 0 else { return nil }
            return ((parameterValue / 100.00) * Double(energy)) / macro.multiplier
        }
        
        switch self {
        case .absolute: return parameterValue
        case .ratioLeanMass: return valueFromLeanMassRatio
        case .ratioBodyWeight: return valueFromBodyweightRatio
        case .percentage: return valueFromPercentage(parameterValue)
        }
    }
}
