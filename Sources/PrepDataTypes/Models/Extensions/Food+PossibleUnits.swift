import Foundation

public extension Food {
    
    func possibleUnits(
        without unit: FoodQuantity.Unit,
        using userVolumeUnits: UserExplicitVolumeUnits) -> [FoodQuantity.Unit]
    {
        possibleUnits(using: userVolumeUnits).filter {
            /// If the units are both sizes—compare the sizes alone to exclude any potential different volume prefixes
            if let possibleSize = $0.size, let size = unit.size {
                return possibleSize.id != size.id
            } else {
                return $0 != unit
            }
        }
    }
    
    func possibleUnits(using userVolumeUnits: UserExplicitVolumeUnits) -> [FoodQuantity.Unit] {
        var units: [FoodQuantity.Unit] = []
        for size in foodQuantitySizes {
            var volumePrefix: VolumeExplicitUnit? = nil
            if let volumeUnit = size.volumePrefixExplicitUnit?.volumeUnit {
                volumePrefix = userVolumeUnits.volumeExplicitUnit(for: volumeUnit)
            }
            units.append(.size(size, volumePrefix))
        }
        if info.serving != nil {
            units.append(.serving)
        }
        if canBeMeasuredInWeight {
            units.append(contentsOf: WeightUnit.allCases.map { .weight($0) })
        }
        let volumeUnits: [VolumeUnit] = [.mL, .liter, .cup, .fluidOunce, .tablespoon, .teaspoon]
        if canBeMeasuredInVolume {
            units.append(contentsOf: volumeUnits.map { .volume(userVolumeUnits.volumeExplicitUnit(for: $0)) })
        }
        return units
    }
}
