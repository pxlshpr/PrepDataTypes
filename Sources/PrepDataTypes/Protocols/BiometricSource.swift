import Foundation

public protocol BiometricSource {
    var fromHealthApp: Bool { get }
    var pickerDescription: String { get }
    var menuDescription: String { get }
    var systemImage: String { get }
}

extension LeanBodyMassSource: BiometricSource {
    public var fromHealthApp: Bool {
        self == .healthApp
    }
}

extension ActiveEnergySource: BiometricSource {
    public var fromHealthApp: Bool {
        self == .healthApp
    }
}

extension RestingEnergySource: BiometricSource {
    public var fromHealthApp: Bool {
        self == .healthApp
    }
}

extension  MeasurementSource: BiometricSource {
    public var fromHealthApp: Bool {
        self == .healthApp
    }
}
