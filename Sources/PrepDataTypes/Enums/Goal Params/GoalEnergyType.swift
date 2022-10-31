//TODO: Why do we need deficit and surplus? wouldn't a negative value imply deficit
// Use this after checking this
public enum GoalEnergyTypeNew: Int16, Codable, CaseIterable {
    case absolute = 1
    case deltaTDEE
    case deltaBMR
    case percentDeltaTDEE
    case percentDeltaBMR
}

public enum GoalEnergyType: Int16, Codable, CaseIterable {
    case absolute = 1
    case deficitTdee
    case deficitBmr
    case surplusTdee
    case surplusBmr
    case percentDeficitTdee
    case percentDeficitBmr
    case percentSurplusTdee
    case percentSurplusBmr
}

public extension GoalEnergyType {
    init(prefix: GoalEnergyTypePrefix?, postfix: GoalEnergyTypePostfix?) {
        guard let prefix = prefix else {
            self = .absolute
            return
        }
        let postfix = postfix ?? .bmr
        switch prefix {
        case .absolute: self = .absolute
        case .deficit: self = postfix == .tdee ? .deficitTdee : .deficitBmr
        case .surplus: self = postfix == .tdee ? .surplusTdee : .surplusBmr
        case .percentDeficit: self = postfix == .tdee ? .percentDeficitTdee : .percentDeficitBmr
        case .percentSurplus: self = postfix == .tdee ? .percentSurplusTdee : .percentSurplusBmr
        }
    }
}

public extension GoalEnergyType {
    var prefix: GoalEnergyTypePrefix {
        switch self {
        case .absolute: return .absolute
        case .deficitTdee: return .deficit
        case .deficitBmr: return .deficit
        case .surplusTdee: return .surplus
        case .surplusBmr: return .surplus
        case .percentDeficitTdee: return .percentDeficit
        case .percentDeficitBmr: return .percentDeficit
        case .percentSurplusTdee: return .percentSurplus
        case .percentSurplusBmr: return .percentSurplus
        }
    }
    
    var postfix: GoalEnergyTypePostfix {
        switch self {
        case .absolute: return .bmr
        case .deficitTdee: return .tdee
        case .deficitBmr: return .bmr
        case .surplusTdee: return .tdee
        case .surplusBmr: return .bmr
        case .percentDeficitTdee: return .tdee
        case .percentDeficitBmr: return .bmr
        case .percentSurplusTdee: return .tdee
        case .percentSurplusBmr: return .bmr
        }
    }
}

extension GoalEnergyType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .absolute: return "absolute"
        case .deficitTdee: return "deficitTdee"
        case .deficitBmr: return "deficitBmr"
        case .surplusTdee: return "surplusTdee"
        case .surplusBmr: return "surplusBmr"
        case .percentDeficitTdee: return "percentDeficitTdee"
        case .percentDeficitBmr: return "percentDeficitBmr"
        case .percentSurplusTdee: return "percentSurplusTdee"
        case .percentSurplusBmr: return "percentSurplusBmr"
        }
    }
}

public extension GoalEnergyType {
    static var all: [String] {
        allCases.map { $0.description }
    }
}

public extension GoalEnergyType {
    
    func parameter(from energy: Double, with baseline: Double) -> Double {
        switch self {
        case .absolute: return energy
        case .deficitTdee: return baseline - energy
        case .deficitBmr: return baseline - energy
        case .surplusTdee: return energy - baseline
        case .surplusBmr: return energy - baseline
        case .percentDeficitTdee: return (baseline - energy)/baseline * 100
        case .percentDeficitBmr: return (baseline - energy)/baseline * 100
        case .percentSurplusTdee: return (energy - baseline)/baseline * 100
        case .percentSurplusBmr: return (energy - baseline)/baseline * 100
        }
    }
    
    func energy(from parameter: Double, with baseline: Double) -> Double {
        switch self {
        case .absolute: return parameter
        case .deficitTdee: return baseline - parameter
        case .deficitBmr: return baseline - parameter
        case .surplusTdee: return baseline + parameter
        case .surplusBmr: return baseline + parameter
        case .percentDeficitTdee: return baseline - ((parameter/100.0) * baseline)
        case .percentDeficitBmr: return baseline - ((parameter/100.0) * baseline)
        case .percentSurplusTdee: return baseline + ((parameter/100.0) * baseline)
        case .percentSurplusBmr: return baseline + ((parameter/100.0) * baseline)
        }
    }
}
