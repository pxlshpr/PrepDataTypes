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
        Task.detached(priority: .utility) {
            
            Logger.log("\(emoji)→ [\(isRequest ? "Request" : "Response") SyncForm] updates: \(updates?.count ?? 0), device: \(deviceModelName), \(isRequest ? "requestedVersion" : "receivedVersion"): \(versionTimestamp.timeStringAtGMT5)", printToConsole: true)
            
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
            Logger.log(" ")
        }
    }
}

extension Double {
    var timeStringAtGMT5: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy HH:mm:ss"
        formatter.timeZone = .init(secondsFromGMT: 5 * 3600)
        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
}

extension Food {
    func log() {
        Logger.log("    [Food] name: \(name)")
        if let deletedAt, deletedAt > 0 {
            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

extension FastingActivity {
    func log() {
        Logger.log("    [FastingActivity] lastMealAt: \(lastMealAt.timeStringAtGMT5)")
        if let deletedAt, deletedAt > 0 {
            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

extension PrepDataTypes.GoalSet {
    func log() {
        Logger.log("    [GoalSet] name: \(name), goals: \(goals.count)")
        if let deletedAt, deletedAt > 0 {
            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

extension PrepDataTypes.Day {
    func log() {
        Logger.log("    [Day] \(calendarDayString)")
        if let goalSet {
            Logger.log("      - goalSet: \(goalSet.name), goals: \(goalSet.goals.count)")
        } else {
            Logger.log("      - goalSet: nil")
        }
        if let bodyProfile {
            Logger.log("      - bodyProfile: [BodyProfile]")
            bodyProfile.log()
        } else {
            Logger.log("      - bodyProfile: nil")
        }
        Logger.log("      - markedAsFasted: \(markedAsFasted)")

    }
}

extension PrepDataTypes.FoodItem {
    func log() {
        Logger.log("    [FoodItem] food: \(food.name), amount: \(amount.description), sort: \(sortPosition)")
        if let meal {
            Logger.log("      - meal: \(meal.name), time: \(meal.time.timeStringAtGMT5)")
        }
        if let deletedAt, deletedAt > 0 {
            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
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

extension PrepDataTypes.Meal {
    func log() {
        Logger.log("    [Meal] name: \(name), time: \(time.timeStringAtGMT5)")
        if let deletedAt, deletedAt > 0 {
            Logger.log("      - deletedAt: \(deletedAt.timeStringAtGMT5)")
        }
    }
}

extension BodyProfile {
    func log() {
        Logger.log("          - energyUnit: \(energyUnit.description)")
        Logger.log("          - weightUnit: \(weightUnit.description)")
        Logger.log("          - heightUnit: \(heightUnit.description)")
        if let restingEnergy { Logger.log("          - restingEnergy: \(restingEnergy)") }
        if let restingEnergySource { Logger.log("          - restingEnergySource: \(restingEnergySource)") }
        if let restingEnergyFormula { Logger.log("          - restingEnergyFormula: \(restingEnergyFormula)") }
        if let restingEnergyPeriod { Logger.log("          - restingEnergyPeriod: \(restingEnergyPeriod)") }
        if let restingEnergyIntervalValue { Logger.log("          - restingEnergyIntervalValue: \(restingEnergyIntervalValue)") }
        if let restingEnergyInterval { Logger.log("          - restingEnergyInterval: \(restingEnergyInterval)") }
        if let activeEnergy { Logger.log("          - activeEnergy: \(activeEnergy)") }
        if let activeEnergySource { Logger.log("          - activeEnergySource: \(activeEnergySource)") }
        if let activeEnergyActivityLevel { Logger.log("          - activeEnergyActivityLevel: \(activeEnergyActivityLevel)") }
        if let activeEnergyPeriod { Logger.log("          - activeEnergyPeriod: \(activeEnergyPeriod)") }
        if let activeEnergyIntervalValue { Logger.log("          - activeEnergyIntervalValue: \(activeEnergyIntervalValue)") }
        if let activeEnergyInterval { Logger.log("          - activeEnergyInterval: \(activeEnergyInterval)") }
        if let fatPercentage { Logger.log("          - fatPercentage: \(fatPercentage)") }
        if let lbm { Logger.log("          - lbm: \(lbm)") }
        if let lbmSource { Logger.log("          - lbmSource: \(lbmSource)") }
        if let lbmFormula { Logger.log("          - lbmFormula: \(lbmFormula)") }
        if let lbmDate { Logger.log("          - lbmDate: \(lbmDate)") }
        if let weight { Logger.log("          - weight: \(weight)") }
        if let weightSource { Logger.log("          - weightSource: \(weightSource)") }
        if let weightDate { Logger.log("          - weightDate: \(weightDate)") }
        if let height { Logger.log("          - height: \(height)") }
        if let heightSource { Logger.log("          - heightSource: \(heightSource)") }
        if let heightDate { Logger.log("          - heightDate: \(heightDate)") }
        if let sexIsFemale { Logger.log("          - sexIsFemale: \(sexIsFemale)") }
        if let sexSource { Logger.log("          - sexSource: \(sexSource)") }
        if let age { Logger.log("          - age: \(age)") }
        if let dobDay { Logger.log("          - dobDay: \(dobDay)") }
        if let dobMonth { Logger.log("          - dobMonth: \(dobMonth)") }
        if let dobYear { Logger.log("          - dobYear: \(dobYear)") }
        if let ageSource { Logger.log("          - ageSource: \(ageSource)") }
    }
}

import Foundation

public class Logger {

    static var directoryURL: URL? {
        let directoryPath = "\(FileManager.default.currentDirectoryPath)/Logs"
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                print("Creating: \(directoryPath)")
                try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error.localizedDescription)");
            }
        }

        return URL(fileURLWithPath: directoryPath)
    }

    static var logFile: URL? {
        guard let directoryURL else { return nil }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        let fileName = "server_\(dateString).log"

        return directoryURL.appendingPathComponent(fileName)
    }

    public static func log(_ message: String, printToConsole: Bool = false) {
        if printToConsole {
            print(message)
        }

        guard let logFile else {
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = .init(secondsFromGMT: 5 * 3600)
        let timestamp = formatter.string(from: Date())
        let string =  "\(timestamp): " + message + "\n"
        guard let data = string.data(using: String.Encoding.utf8) else { return }

        do {
            if FileManager.default.fileExists(atPath: logFile.path) {
                let fileHandle = try FileHandle(forWritingTo: logFile)
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } else {
                try string.write(to: logFile, atomically: true, encoding: String.Encoding.utf8)
            }
//            print("Wrote to: \(logFile)")
        } catch {
            print("Could not write to: \(logFile) – \(error)")
        }
    }
}
