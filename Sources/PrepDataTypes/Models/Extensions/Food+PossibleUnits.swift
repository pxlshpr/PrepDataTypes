import Foundation

public extension Food {
    
    func possibleUnits(
        without unit: FoodQuantity.Unit,
        using userVolumeUnits: UserExplicitVolumeUnits) -> [FoodQuantity.Unit]
    {
        possibleUnits(using: userVolumeUnits).filter {
            /// If the units are both sizes—compare the sizes alone to exclude any potential different volume prefixes
            if let possibleSize = $0.size, let size = unit.size {
                return possibleSize.id == size.id
            } else {
                return $0 != unit
            }
        }
    }
    
    func possibleUnits(using userVolumeUnits: UserExplicitVolumeUnits) -> [FoodQuantity.Unit] {
        var units: [FoodQuantity.Unit] = []
        for size in foodQuantitySizes {
            units.append(.size(size, nil))
        }
        if info.serving != nil {
            units.append(.serving)
        }
        if canBeMeasuredInWeight {
            units.append(.weight(.g))
            units.append(.weight(.oz))
        }
        if canBeMeasuredInVolume {
            units.append(.volume(.ml))
            units.append(.volume(userVolumeUnits.fluidOunce))
            units.append(.volume(userVolumeUnits.cup))
            units.append(.volume(userVolumeUnits.tablespoon))
            units.append(.volume(userVolumeUnits.teaspoon))
        }
        return units
    }
}

extension FoodQuantity.Size {
    public var id: String {
        if let volumePrefixExplicitUnit {
            return "\(name)\(volumePrefixExplicitUnit.volumeUnit.rawValue)"
        } else {
            return name
        }
    }
}
