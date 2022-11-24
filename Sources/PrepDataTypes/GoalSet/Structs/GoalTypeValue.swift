import Foundation

public struct GoalTypeValue: Codable, Hashable {
    public var flattenedType: FlattenedGoalType
    
    public var energyUnit: EnergyUnit?
    public var energyDelta: EnergyGoalDelta?
    public var macro: Macro?
    public var nutrientType: NutrientType?
    public var nutrientUnit: NutrientUnit?
    
    public var bodyMass: NutrientGoalBodyMassType?
    public var weightUnit: WeightUnit?
    public var energyQuantity: Double?
    public var workoutDurationUnit: WorkoutDurationUnit?
}

public enum FlattenedGoalType: Int16, Codable, Hashable {
    
    case energyFixed = 1
    case energyFromMaintenance
    case energyPercentageFromMaintenance

    case nutrientFixed = 100
    case nutrientQuantityPerBodyMass
    case nutrientQuantityPerEnergy
    case nutrientPercentageOfEnergy
    case nutrientQuantityPerWorkoutDuration
}
