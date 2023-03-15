import Foundation

public struct GoalCalcParams {
    public let units: UserOptions.Units
    public let biometrics: Biometrics?
    public let energyGoal: Goal?
    
    public init(units: UserOptions.Units, biometrics: Biometrics?, energyGoal: Goal?) {
        self.units = units
        self.biometrics = biometrics
        self.energyGoal = energyGoal
    }
}
