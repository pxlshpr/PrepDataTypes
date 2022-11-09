import Foundation

public struct SizeQuantity: Hashable {
    let value: Double
    let size: FoodQuantity.Size
    var volumePrefixUnit: VolumeExplicitUnit? = nil
}

public extension SizeQuantity {
    init(_ value: Double, _ size: FoodQuantity.Size, _ volumePrefixUnit: VolumeExplicitUnit?) {
        self.init(value: value, size: size, volumePrefixUnit: volumePrefixUnit)
    }
    
    init(_ value: Double, _ size: FoodQuantity.Size) {
        self.init(value: value, size: size)
    }
}

extension SizeQuantity: Equatable {
    /// Note: Equality is determined by comparing values to **two decimal places**
    public static func ==(lhs: SizeQuantity, rhs: SizeQuantity) -> Bool {
        lhs.size == rhs.size
        && lhs.volumePrefixUnit == rhs.volumePrefixUnit
        && lhs.value.rounded(toPlaces: 2) == rhs.value.rounded(toPlaces: 2)
    }
}
