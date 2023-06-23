import Foundation

extension SyncForm {
    
    public var description: String {
        if isEmpty {
            return "Version: \(versionTimestamp.timeStringAtGMT5)"
        } else {
            return "Updates: \(updates?.count ?? 0) Version: \(versionTimestamp.timeStringAtGMT5)"
        }
    }

    public func log(emoji: String, isRequest: Bool, includeBreakdown: Bool) {
//        Logger.log("\(emoji)→ [\(isRequest ? "Request" : "Response") SyncForm] updates: \(updates?.count ?? 0), device: \(deviceModelName), \(isRequest ? "requestedVersion" : "receivedVersion"): \(versionTimestamp.timeStringAtGMT5)", printToConsole: true)
        
        guard includeBreakdown else { return }

        if let days = updates?.days {
            for day in days {
                day.log()
            }
        }

        if let meals = updates?.meals {
            for meal in meals {
                meal.log()
            }
        }

        if let foodItems = updates?.foodItems {
            for foodItem in foodItems {
                foodItem.log()
            }
        }

        if let foods = updates?.foods {
            for food in foods {
                food.log()
            }
        }

        if let goalSets = updates?.goalSets {
            for goalSet in goalSets {
                goalSet.log()
            }
        }
        
        if let activities = updates?.fastingActivities {
            for activity in activities {
                activity.log()
            }
        }
//        Logger.log(" ")
    }
}

extension Date {
    public var timeStringAtGMT5: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy HH:mm:ss"
        formatter.timeZone = .init(secondsFromGMT: 5 * 3600)
        return formatter.string(from: self)
    }
}

extension Double {
    public var timeStringAtGMT5: String {
        Date(timeIntervalSince1970: self).timeStringAtGMT5
    }
}

public extension Food {
    func log() {
//        Logger.log("    [Food] name: \(name)")
        if let deletedAt, deletedAt > 0 {
//            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

public extension FastingActivity {
    func log() {
//        Logger.log("    [FastingActivity] lastMealAt: \(lastMealAt.timeStringAtGMT5)")
        if let deletedAt, deletedAt > 0 {
//            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

public extension PrepDataTypes.GoalSet {
    func log() {
//        Logger.log("    [GoalSet] name: \(name), goals: \(goals.count)")
        if let deletedAt, deletedAt > 0 {
//            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

public extension PrepDataTypes.Day {
    func log() {
//        Logger.log("    [Day] \(calendarDayString)")
        if let goalSet {
//            Logger.log("      - goalSet: \(goalSet.name), goals: \(goalSet.goals.count)")
        } else {
//            Logger.log("      - goalSet: nil")
        }
        if let biometrics {
//            Logger.log("      - biometrics: [Biometrics]")
            biometrics.log()
        } else {
//            Logger.log("      - biometrics: nil")
        }
//        Logger.log("      - markedAsFasted: \(markedAsFasted)")

    }
}

public extension PrepDataTypes.FoodItem {
    func log() {
//        Logger.log("    [FoodItem] food: \(food.name), amount: \(amount.description), sort: \(sortPosition)")
        if let meal {
//            Logger.log("      - meal: \(meal.name), time: \(meal.time.timeStringAtGMT5)")
        }
        if let deletedAt, deletedAt > 0 {
//            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

extension FoodValue {
    var description: String {
        switch unitType {
        case .serving:
            return "\(value.cleanAmount) servings"
        case .volume:
            let volumeUnit = self.volumeExplicitUnit?.volumeUnit.shortDescription ?? ""
            return "\(value.cleanAmount) \(volumeUnit)"
        case .weight:
            let weightUnit = self.weightUnit?.shortDescription ?? ""
            return "\(value.cleanAmount) \(weightUnit)"
        case .size:
            let size = sizeUnitId ?? ""
            if let sizeUnitVolumePrefixExplicitUnit {
                return "\(value.cleanAmount) \(sizeUnitVolumePrefixExplicitUnit.volumeUnit.shortDescription) \(size)"
            } else {
                return "\(value.cleanAmount) \(size)"
            }
        }
    }
}

public extension PrepDataTypes.Meal {
    func log() {
//        Logger.log("    [Meal] name: \(name), time: \(time.timeStringAtGMT5)")
        if let deletedAt, deletedAt > 0 {
//            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

public extension Biometrics {
    func log() {
//        Logger.log("(Biometrics.log() not implemented)")
    }
}

import Foundation

public class Logger {
    
    public static let serialQueue = DispatchQueue(label: "serialQueue")
    public static let group = DispatchGroup()
//    group.enter()
//    serialQueue.async{  //call this whenever you need to add a new work item to your queue
//        fetchA{
//            //in the completion handler call
//            group.leave()
//        }
//    }
//    serialQueue.async{
//        group.wait()
//        group.enter()
//        fetchB{
//            //in the completion handler call
//            group.leave()
//        }
//    }
//    serialQueue.async{
//        group.wait()
//        group.enter()
//        fetchC{
//            group.leave()
//        }
//    }

    static var directoryURL: URL? {
        if FileManager.default.currentDirectoryPath != "/" {
            let directoryPath = "\(FileManager.default.currentDirectoryPath)/Logs"
            if !FileManager.default.fileExists(atPath: directoryPath) {
                do {
//                    print("Creating: \(directoryPath)")
                    try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                } catch {
//                    print("Error creating directory: \(error.localizedDescription)");
                }
            }
            return URL(fileURLWithPath: directoryPath)
        } else {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
    }

    public static var logFile: URL? {
        guard let directoryURL else { return nil }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        
        let prefix = FileManager.default.currentDirectoryPath == "/" ? "device" : "server"
        let fileName = "\(prefix)_\(dateString).log"

        return directoryURL.appendingPathComponent(fileName)
    }

    public static func log(_ message: String, printToConsole: Bool = false) {
        serialQueue.async {
            group.wait()
            group.enter()

//            if printToConsole {
//                print(message)
//            }

            guard let logFile else {
                group.leave()
                return
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = .init(secondsFromGMT: 5 * 3600)
            let timestamp = formatter.string(from: Date())
            let string =  "\(timestamp): " + message + "\n"
            guard let data = string.data(using: String.Encoding.utf8) else {
                group.leave()
                return
            }

            do {
                if FileManager.default.fileExists(atPath: logFile.path) {
                    let fileHandle = try FileHandle(forWritingTo: logFile)
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                } else {
                    try string.write(to: logFile, atomically: true, encoding: String.Encoding.utf8)
                }
                
    //            print("💾 Wrote to: \(logFile)")
                
            } catch {
//                print("Could not write to: \(logFile) – \(error)")
            }
            group.leave()
        }
    }
}
