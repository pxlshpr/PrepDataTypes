import Foundation

public extension Meal {
    var isCompleted: Bool {
        markedAsEatenAt != nil
        && markedAsEatenAt != 0
    }
}

