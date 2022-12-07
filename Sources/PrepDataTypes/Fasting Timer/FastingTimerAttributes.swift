#if os(iOS)
import Foundation
import ActivityKit

public struct FastingTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public var value: Int
        
        public init(value: Int) {
            self.value = value
        }
    }

    // Fixed non-changing properties about your activity go here!
//    var name: String
    public var date: Date

    public init(date: Date) {
        self.date = date
    }
}
#endif
