import Foundation

public struct GoalCalcParams {
    public let userUnits: UserUnits
    public let bodyProfile: BodyProfile?
    public let energyGoal: Goal?
    
    public init(userUnits: UserUnits, bodyProfile: BodyProfile?, energyGoal: Goal?) {
        self.userUnits = userUnits
        self.bodyProfile = bodyProfile
        self.energyGoal = energyGoal
    }
}
