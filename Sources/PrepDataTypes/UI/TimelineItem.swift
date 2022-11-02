import SwiftUI
import SwiftSugar

public class TimelineItem: ObservableObject {
    
    @Published public var date: Date
    public var isNew: Bool
    public var id: String
    public var name: String
    public var duration: TimeInterval?
    public var emojis: [Emoji]
    public var type: TimelineItemType
    public var isEmptyItem: Bool
    public var groupedWorkouts: [TimelineItem]
    public var isNow: Bool
    
    public required init(id: String? = nil, name: String, date: Date, duration: TimeInterval? = nil, emojis: [Emoji] = [], type: TimelineItemType = .meal, isNew: Bool = false, isEmptyItem: Bool = false, isNow: Bool = false) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.date = date
        self.duration = duration
        self.emojis = emojis
        self.type = type
        self.isNew = isNew
        self.isEmptyItem = isEmptyItem
        self.groupedWorkouts = []
        self.isNow = isNow
    }
    
    public required init(id: String? = nil, name: String, date: Date, duration: TimeInterval? = nil, emojiStrings: [String], type: TimelineItemType = .meal, isNew: Bool = false, isEmptyItem: Bool = false, isNow: Bool = false) {
        self.id = id ?? UUID().uuidString
        self.name = name
        self.date = date
        self.duration = duration
        self.emojis = emojiStrings.map { Emoji(emoji: $0) }
        self.type = type
        self.isNew = isNew
        self.isEmptyItem = isEmptyItem
        self.groupedWorkouts = []
        self.isNow = isNow
    }

    
    public static var emptyMeal: TimelineItem {
        Self.init(id: "", name: "", date: Date(), type: .meal, isEmptyItem: true)
    }
}

extension TimelineItem: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(isNew)
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(duration)
        hasher.combine(emojis)
        hasher.combine(type)
        hasher.combine(isEmptyItem)
        hasher.combine(groupedWorkouts)
        hasher.combine(isNow)
    }
    public static func ==(lhs: TimelineItem, rhs: TimelineItem) -> Bool {
        lhs.date == rhs.date
        && lhs.isNew == rhs.isNew
        && lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.duration == rhs.duration
        && lhs.emojis == rhs.emojis
        && lhs.type == rhs.type
        && lhs.isEmptyItem == rhs.isEmptyItem
        && lhs.groupedWorkouts == rhs.groupedWorkouts
        && lhs.isNow == rhs.isNow
    }
}

public extension TimelineItem {
    func groupWorkout(_ item: TimelineItem) {
        guard !groupedWorkouts.contains(where: { $0.id == item.id }) else {
            return
        }
        emojis.append(contentsOf: item.emojis)
        groupedWorkouts.append(item)
    }
    
    var endTime: Date? {
        guard let duration = duration else {
            return nil
        }
        return date.addingTimeInterval(duration)
    }
}

public extension TimelineItem {
    var dateString: String {
        guard type == .workout, let itemEndTime = endTime else {
            return date.shortTime
        }
        
        let endTime: Date
        if let lastItemEndTime = groupedWorkouts.last?.endTime {
            endTime = lastItemEndTime
        } else {
            endTime = itemEndTime
        }
        
        return "\(date.shortTime) – \(endTime.shortTime)"
    }
    
    var titleString: String {
        if !groupedWorkouts.isEmpty {
            return "Workout Session"
        } else {
            return name
        }
    }
    
    var allWorkouts: [TimelineItem] {
        guard !groupedWorkouts.isEmpty else {
            return []
        }
        var workouts = [self]
        workouts.append(contentsOf: groupedWorkouts)
        return workouts
    }
    
    var workoutStrings: [(id: String, name: String, duration: String)] {
        allWorkouts.map { workout in
            (workout.id, workout.name, (workout.duration ?? 0).stringTime)
        }
    }
    
}

public extension TimelineItem {
    static var now: TimelineItem {
        TimelineItem(name: "", date: Date(), isNow: true)
    }
}
