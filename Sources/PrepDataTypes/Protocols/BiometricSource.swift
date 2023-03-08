import Foundation

public protocol BiometricSource {
    var isHealthSynced: Bool { get }
    var isUserEntered: Bool { get }
    var pickerDescription: String { get }
    var menuDescription: String { get }
    var systemImage: String { get }
}

extension LeanBodyMassSource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .healthApp
    }
    
    public var isUserEntered: Bool {
        self == .userEntered
    }
}

extension ActiveEnergySource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .healthApp
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}

extension RestingEnergySource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .healthApp
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}

extension  MeasurementSource: BiometricSource {
    public var isHealthSynced: Bool {
        self == .healthApp
    }
    public var isUserEntered: Bool {
        self == .userEntered
    }
}
