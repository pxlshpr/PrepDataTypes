#if os(iOS)
import Foundation

public extension Array where Element == TimelineItem {
    var sortedByDate: [TimelineItem] {
        sorted(by: { $0.date < $1.date })
    }
    
    var addingNow: [TimelineItem] {
        self + [TimelineItem.now]
    }
    
    var groupingWorkouts: [TimelineItem] {
        let sorted = sortedByDate
        
        var grouped: [TimelineItem] = []
        var groupedItemIndices: [Int] = []
        /// go through each item
        for i in sorted.indices {
            guard !groupedItemIndices.contains(i) else {
                continue
            }
            
            let item = sorted[i]
            
            /// if we've got a workout
            guard item.type == .workout else {
                grouped.append(item)
                continue
            }
            
            /// check if the next workout down the list is within 15 minutes of its end
            var nextWorkout: TimelineItem? = nil
            repeat {
                if let nextWorkoutIndex = sorted.indexOfWorkoutItemDirectlyAfter(nextWorkout ?? item) {
                    item.groupWorkout(sorted[nextWorkoutIndex])
                    nextWorkout = sorted[nextWorkoutIndex]
                    groupedItemIndices.append(nextWorkoutIndex)
                } else {
                    nextWorkout = nil
                }
            } while nextWorkout != nil
            /// if so, group them by adding the workout to the item, and addiong its index to the list of those to ignore
            /// now check the next workout for this grouped workout, and see if it too has another one within 15 mintues of its end, and keep going till we have no more
            
            grouped.append(item)
        }
        return grouped
    }
    
    func indexOfWorkoutItemDirectlyAfter(_ item: TimelineItem) -> Int? {
        guard let index = firstIndex(where: { $0.id == item.id}), item.type == .workout, let endTime = item.endTime else {
            return nil
        }
        
        for i in index+1..<count {
            guard self[i].type == .workout else {
                continue
            }
            
            guard abs(endTime.timeIntervalSince(self[i].date)) <= (15 * 60) else {
                return nil
            }
            return i
        }
        return nil
    }
}
#endif
