import Foundation

extension FoodQuantity {
    func equivalentQuantities(using: UserExplicitVolumeUnits = .defaultUnits) -> [FoodQuantity] {
        food
            .possibleUnits(without: unit, using: .defaultUnits)
            .compactMap { convert(to: $0) }
    }
}
