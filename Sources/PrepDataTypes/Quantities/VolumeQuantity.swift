import Foundation

public struct VolumeQuantity: Hashable {
    let value: Double
    let unit: VolumeExplicitUnit
}

public extension VolumeQuantity {
    init(_ value: Double, _ unit: VolumeExplicitUnit) {
        self.init(value: value, unit: unit)
    }
}

extension VolumeQuantity: Equatable {
    /// Note: Equality is determined by comparing values to **two decimal places**
    public static func ==(lhs: VolumeQuantity, rhs: VolumeQuantity) -> Bool {
        lhs.unit == rhs.unit
        && lhs.value.rounded(toPlaces: 2) == rhs.value.rounded(toPlaces: 2)
    }
}

public extension VolumeQuantity {
    var valueInMls: Double {
        value * unit.ml
    }
    
    func convert(to volumeUnit: VolumeExplicitUnit) -> Double {
        valueInMls / volumeUnit.ml
    }
}
