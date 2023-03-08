import Foundation

public struct GoalCalcParams {
    public let userUnits: UserOptions.Units
    public let biometrics: Biometrics?
    public let energyGoal: Goal?
    
    public init(userUnits: UserOptions.Units, biometrics: Biometrics?, energyGoal: Goal?) {
        self.userUnits = userUnits
        self.biometrics = biometrics
        self.energyGoal = energyGoal
    }
}
