import Foundation

public enum FastingMilestone: Int, CaseIterable {
    case anabolic
    case catabolic
    case ketosis
    case heavyKetosis
    case autophagy
    case peakHGH
    case minimumInsulin
    case immuneRegeneration
    
    public init(hours: Int) {
        for milestone in Self.allCases.reversed() {
            if hours >= milestone.startHour {
                self = milestone
                return
            }
        }
        self = .anabolic
    }
    
    public init(time: Date) {
        let hours = Int(Date().timeIntervalSince(time) / 3600.0)
        self.init(hours: hours)
    }
}

public extension FastingMilestone {
    var nextMilestone: FastingMilestone? {
        switch self {
        case .anabolic:
            return .catabolic
        case .catabolic:
            return .ketosis
        case .ketosis:
            return .heavyKetosis
        case .heavyKetosis:
            return .autophagy
        case .autophagy:
            return .peakHGH
        case .peakHGH:
            return .minimumInsulin
        case .minimumInsulin:
            return .immuneRegeneration
        case .immuneRegeneration:
            return nil
        }
    }
}

public extension FastingMilestone {
    var emoji: String {
        switch self {
        case .anabolic:
            return "🛠"
        case .catabolic:
            return "⚡️"
        case .ketosis:
            return "🔥"   //"🥑"
        case .heavyKetosis:
            return "🌋"   //"🔥"
        case .autophagy:
            return "♻️"
        case .peakHGH:
            return "💪"
        case .minimumInsulin:
            return "📉"
        case .immuneRegeneration:
            return "✨"
        }
    }
    
    var name: String {
        switch self {
        case .anabolic:
            return "Anabolic Phase"
        case .catabolic:
            return "Catabolic Phase"
        case .ketosis:
            return "Ketosis"
        case .heavyKetosis:
            return "Heavy Ketosis"
        case .autophagy:
            return "Autophagy"
        case .peakHGH:
            return "Peak HGH Levels"
        case .minimumInsulin:
            return "Minimum Insulin"
        case .immuneRegeneration:
            return "Immunge Regeneration"
        }
    }
    
    var startHour: Int {
        switch self {
        case .anabolic:
            return 0
        case .catabolic:
            return 4
        case .ketosis:
            return 12
        case .heavyKetosis:
            return 18
        case .autophagy:
            return 24
        case .peakHGH:
            return 48
        case .minimumInsulin:
            return 54
        case .immuneRegeneration:
            return 72
        }
    }
    
    var startTimeInterval: TimeInterval {
        Double(startHour) * 3600.0
    }
    
    var timeIntervalToNextMilestone: TimeInterval? {
        guard let nextMilestone else { return nil }
        return nextMilestone.startTimeInterval - startTimeInterval
    }
    
    var detail: String {
        switch self {
        case .anabolic:
            return "This is when our body is digesting or absorbing food."
        case .catabolic:
            return "As your blood glucose continues to drop, stored nutrients like glycogen and fat are being put to use."
        case .ketosis:
            return "Your body is entering ketosis, and is starting to break down and burn fat as a source of fuel."
        case .heavyKetosis:
            return "You're deep into fat-burning mode and would be generating significant ketones by now."
        case .autophagy:
            return "Your cells are increasingly recycling old components and breaking down misfolded proteins linked to Alzheimer’s and other diseases."
        case .peakHGH:
            return "Your growth hormone level is up to 500% higher than when you started your fast."
        case .minimumInsulin:
            return "Your insulin has dropped to its lowest level since you started fasting and your body is becoming increasingly insulin-sensitive."
        case .immuneRegeneration:
            return "Your body is breaking down old immune cells and generating new ones."
        }
    }
}
