import Foundation

public extension Food {
    
    func possibleUnits(
        without unit: FoodQuantity.Unit,
        using userVolumeUnits: UserExplicitVolumeUnits) -> [FoodQuantity.Unit]
    {
        possibleUnits(using: userVolumeUnits).filter { $0 != unit }
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
