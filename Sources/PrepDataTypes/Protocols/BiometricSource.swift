import Foundation

public protocol BiometricSource {
    var isHealthSynced: Bool { get }
    var isUserEntered: Bool { get }
    var pickerDescription: String { get }
    var menuDescription: String { get }
    var systemImage: String { get }
    var isUserEnteredAndComputed: Bool { get }
}

extension BiometricSource {
    public var isUserEnteredAndComputed: Bool {
        false
    }
}

extension LeanBodyMassSource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .health
    }
    
    public var isUserEntered: Bool {
        self == .userEntered
    }
    
    public var isUserEnteredAndComputed: Bool {
        self == .fatPercentage
    }
}

extension ActiveEnergySource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .health
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}

extension RestingEnergySource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .health
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}

extension MeasurementSource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .health
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}
