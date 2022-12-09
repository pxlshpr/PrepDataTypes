
#if os(iOS)
import Foundation
import ActivityKit

public struct FastingTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public var fastingState: FastingTimerState
        
        public init(fastingState: FastingTimerState) {
            self.fastingState = fastingState
        }
    }

    // Fixed non-changing properties about your activity go here!
    public init() {
    }
}
#endif
