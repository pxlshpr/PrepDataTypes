import Foundation

public extension FoodQuantity {
    func equivalentQuantities(using: UserExplicitVolumeUnits = .defaultUnits) -> [FoodQuantity] {
        let units = food.possibleUnits(without: unit, using: .defaultUnits)
        return units
            .compactMap { convert(to: $0) }
            .filter({ $0.value >= 0.1 && $0.value < 1000 })
    }
}
