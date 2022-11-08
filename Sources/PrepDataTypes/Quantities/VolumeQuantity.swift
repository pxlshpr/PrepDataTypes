import Foundation

public struct VolumeQuantity: Hashable, Equatable {
    let value: Double
    let unit: VolumeExplicitUnit
    
    /// Note: Equality is determined by comparing values to **two decimal places**
    public static func ==(lhs: VolumeQuantity, rhs: VolumeQuantity) -> Bool {
        lhs.unit == rhs.unit
        && lhs.value.rounded(toPlaces: 2) == rhs.value.rounded(toPlaces: 2)
    }
    
    var valueInMls: Double {
        value * unit.ml
    }
    
    func convert(to volumeUnit: VolumeExplicitUnit) -> Double {
        valueInMls / volumeUnit.ml
    }
}
