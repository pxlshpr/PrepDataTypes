import Foundation

public struct FastingTimerForm: Codable {
    public let fastingTimerState: FastingTimerState
    public let userId: UUID
    
    public init(fastingTimerState: FastingTimerState, userId: UUID) {
        self.fastingTimerState = fastingTimerState
        self.userId = userId
    }
}
