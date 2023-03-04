import Foundation

public struct GoalCalcParams {
    public let userOptions: UserOptions
    public let bodyProfile: BodyProfile?
    public let energyGoal: Goal?
    
    public init(userOptions: UserOptions, bodyProfile: BodyProfile?, energyGoal: Goal?) {
        self.userOptions = userOptions
        self.bodyProfile = bodyProfile
        self.energyGoal = energyGoal
    }
}
