import Foundation

public struct UserExplicitVolumeUnits: Codable, Hashable {
    public let cup: VolumeExplicitUnit
    public let teaspoon: VolumeExplicitUnit
    public let tablespoon: VolumeExplicitUnit
    public let fluidOunce: VolumeExplicitUnit
    public let pint: VolumeExplicitUnit
    public let quart: VolumeExplicitUnit
    public let gallon: VolumeExplicitUnit
    
    public init(
        cup: VolumeExplicitUnit = .cupMetric,
        teaspoon: VolumeExplicitUnit = .teaspoonMetric,
        tablespoon: VolumeExplicitUnit = .tablespoonMetric,
        fluidOunce: VolumeExplicitUnit = .fluidOunceUSNutritionLabeling,
        pint: VolumeExplicitUnit = .pintMetric,
        quart: VolumeExplicitUnit = .quartUSLiquid,
        gallon: VolumeExplicitUnit = .gallonUSLiquid
    ) {
        //TODO: Validate the values, making sure we're assigning a 'cup' unit to cup etc...
        self.cup = cup
        self.teaspoon = teaspoon
        self.tablespoon = tablespoon
        self.fluidOunce = fluidOunce
        self.pint = pint
        self.quart = quart
        self.gallon = gallon
    }
}

public extension UserExplicitVolumeUnits {
    static var defaultUnits: UserExplicitVolumeUnits {
        UserExplicitVolumeUnits(
            cup: .cupMetric,
            teaspoon: .teaspoonMetric,
            tablespoon: .tablespoonMetric,
            fluidOunce: .fluidOunceUSNutritionLabeling,
            pint: .pintMetric,
            quart: .quartUSLiquid,
            gallon: .gallonUSLiquid
        )
    }
}

public extension UserExplicitVolumeUnits {
    func volumeExplicitUnit(for volumeUnit: VolumeUnit) -> VolumeExplicitUnit {
        switch volumeUnit {
        case .gallon:       return gallon
        case .quart:        return quart
        case .pint:         return pint
        case .cup:          return cup
        case .fluidOunce:   return fluidOunce
        case .tablespoon:   return tablespoon
        case .teaspoon:     return teaspoon
        case .mL:           return .ml
        case .liter:        return .liter
        }
    }
    
    func volumeExplicitUnit(for volumeFormUnit: FormUnit) -> VolumeExplicitUnit? {
        guard let volumeUnit = volumeFormUnit.volumeUnit else { return nil }
        return volumeExplicitUnit(for: volumeUnit)
    }
}
