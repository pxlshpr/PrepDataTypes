import Foundation

extension FoodQuantity {
    func equivalentQuantities(using: UserExplicitVolumeUnits = .defaultUnits) -> [FoodQuantity] {
//        let possibleUnits = food.possibleUnits(without: unit, using: .defaultUnits)
        let possibleUnits = food.possibleUnits(using: .defaultUnits)
        let equivalentQuantities = possibleUnits.compactMap { convert(to: $0) }
        return equivalentQuantities
    }
}
