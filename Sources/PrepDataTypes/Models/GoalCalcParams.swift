import Foundation

public struct GoalCalcParams {
    public let userUnits: UserOptions.Units
    public let bodyProfile: BodyProfile?
    public let energyGoal: Goal?
    
    public init(userUnits: UserOptions.Units, bodyProfile: BodyProfile?, energyGoal: Goal?) {
        self.userUnits = userUnits
        self.bodyProfile = bodyProfile
        self.energyGoal = energyGoal
    }
}
