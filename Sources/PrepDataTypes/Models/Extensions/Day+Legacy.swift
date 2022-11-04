//TODO: Bring these back

//import SwiftUI
//
//extension Day {
//    var totalGoalEnergy: Double? {
//        0
////        guard let goal = goal else { return nil }
////        return goal.energyValue + workoutsEnergy
//    }
//
//    var energyLeft: Double? {
//        0
////        guard let goalEnergy = totalGoalEnergy else { return nil }
////        return goalEnergy - energyAmount
//    }
//}
//
//extension Day {
//
//    var energyConsumedFromPlannedProgress: Double {
//        guard energyPlanned != 0 else { return 0 }
//        return energyConsumed / energyPlanned
//    }
//
//    var energyConsumedFromGoalProgress: Double {
//        guard energyGoal != 0 else { return 0 }
//        return energyConsumed / energyGoal
//    }
//
//    var energyPlannedProgress: Double {
//        guard energyGoal != 0 else { return 0 }
//        return energyPlanned / energyGoal
//    }
//
//    var carbConsumedFromPlannedProgress: Double {
//        guard carbPlanned != 0 else { return 0 }
//        return carbConsumed / carbPlanned
//    }
//    var carbConsumedFromGoalProgress: Double {
//        guard carbGoal != 0 else { return 0 }
//        return carbConsumed / carbGoal
//    }
//    var carbPlannedProgress: Double {
//        guard carbGoal != 0 else { return 0 }
//        return carbPlanned / carbGoal
//    }
//
//    var fatConsumedFromPlannedProgress: Double {
//        guard fatPlanned != 0 else { return 0 }
//        return fatConsumed / fatPlanned
//    }
//    var fatConsumedFromGoalProgress: Double {
//        guard fatGoal != 0 else { return 0 }
//        return fatConsumed / fatGoal
//    }
//    var fatPlannedProgress: Double {
//        guard fatGoal != 0 else { return 0 }
//        return fatPlanned / fatGoal
//    }
//
//    var proteinConsumedFromPlannedProgress: Double {
//        guard proteinPlanned != 0 else { return 0 }
//        return proteinConsumed / proteinPlanned
//    }
//    var proteinConsumedFromGoalProgress: Double {
//        guard proteinGoal != 0 else { return 0 }
//        return proteinConsumed / proteinGoal
//    }
//    var proteinPlannedProgress: Double {
//        guard proteinGoal != 0 else { return 0 }
//        return proteinPlanned / proteinGoal
//    }
//
//    // MARK: - Strings
//    private var energyRemainingToConsumeFromPlannedString: String {
//        energyRemainingToConsumeFromPlanned.formattedEnergy
//    }
//    private var energyRemainingToConsumeFromGoalString: String {
//        let value = isOverConsumedFromGoal ? -energyRemainingToConsumeFromGoal : energyRemainingToConsumeFromGoal
//        return value.formattedEnergy
//    }
//    private var energyRemainingToPlanString: String {
//        let value = isOverPlanned ? -energyRemainingToPlan : energyRemainingToPlan
//        return value.formattedEnergy
//    }
//
//    var isOverPlanned: Bool {
//        energyPlannedProgress > 1.0
//    }
//
//    var isOverConsumedFromGoal: Bool {
//        energyConsumedFromGoalProgress > 1.0
//    }
//
//    private var energyConsumedString: String { energyConsumed.formattedEnergy }
//    private var energyPlannedString: String { energyPlanned.formattedEnergy }
//    private var energyGoalString: String { energyGoal.formattedEnergy }
//
//    private var carbConsumedString: String { carbConsumed.formattedMacro }
//    private var carbPlannedString: String { carbPlanned.formattedMacro }
//    private var carbGoalString: String { carbGoal.formattedMacro }
//
//    private var fatConsumedString: String { fatConsumed.formattedMacro }
//    private var fatPlannedString: String { fatPlanned.formattedMacro }
//    private var fatGoalString: String { fatGoal.formattedMacro }
//    private var proteinConsumedString: String { proteinConsumed.formattedMacro }
//    private var proteinPlannedString: String { proteinPlanned.formattedMacro }
//    private var proteinGoalString: String { proteinGoal.formattedMacro }
//
//}
//
//
//extension Day {
//
//    var energyConsumed: Double {
//        mealsArray
//        .flatMap { $0.itemsArray }
//        .filter { $0.isCompleted }
//        .reduce(0) { $0 + $1.energyAmount }
//    }
//
//    var energyPlanned: Double {
//        mealsArray.reduce(0) { partialResult, meal in
//            partialResult + meal.energyAmount
//        }
//    }
//
//    var carbConsumed: Double {
//        mealsArray
//        .flatMap { $0.itemsArray }
//        .filter { $0.isCompleted }
//        .reduce(0) { $0 + $1.carbAmount }
//    }
//
//    var carbPlanned: Double {
//        mealsArray.reduce(0) { partialResult, meal in
//            partialResult + meal.carbAmount
//        }
//    }
//
//    var fatConsumed: Double {
//        mealsArray
//        .flatMap { $0.itemsArray }
//        .filter { $0.isCompleted }
//        .reduce(0) { $0 + $1.fatAmount }
//    }
//
//    var fatPlanned: Double {
//        mealsArray.reduce(0) { partialResult, meal in
//            partialResult + meal.fatAmount
//        }
//    }
//
//    var proteinConsumed: Double {
//        mealsArray
//        .flatMap { $0.itemsArray }
//        .filter { $0.isCompleted }
//        .reduce(0) { $0 + $1.proteinAmount }
//    }
//
//    var proteinPlanned: Double {
//        mealsArray.reduce(0) { partialResult, meal in
//            partialResult + meal.proteinAmount
//        }
//    }
//
//    var isCompleted: Bool {
//        mealsArray.allSatisfy { $0.isCompleted }
//    }
//
//    var energyRemainingToConsumeFromPlanned: Double {
//        energyPlanned - energyConsumed
//    }
//
//    var energyRemainingToConsumeFromGoal: Double {
//        energyGoal - energyConsumed
//    }
//
//    func macroRemainingToConsumeFromGoal(for macro: Macro) -> Double {
//        switch macro {
//        case .carb:
//            return carbGoal - carbConsumed
//        case .fat:
//            return fatGoal - fatConsumed
//        case .protein:
//            return proteinGoal - proteinConsumed
//        }
//    }
//
//    func macroRemainingToPlan(for macro: Macro) -> Double {
//        switch macro {
//        case .carb:
//            return carbGoal - carbPlanned
//        case .fat:
//            return fatGoal - fatPlanned
//        case .protein:
//            return proteinGoal - proteinPlanned
//        }
//    }
//
//    var energyRemainingToPlan: Double {
//        energyGoal - energyPlanned
//    }
//
//    var goalEnergy: Double {
//        goal?.energyValue ?? 0
//    }
//
//    var goalCarb: Double {
//        goal?.carbValue ?? 0
//    }
//
//    var goalProtein: Double {
//        goal?.proteinValue ?? 0
//    }
//
//    var goalFat: Double {
//        goal?.fatValue ?? 0
//    }
//
//    //MARK: - Legacy (to be removed as its confusing by having workouts included)
//    var energyGoal: Double {
//        (goal?.energyValue ?? 0) + workoutsEnergy
//    }
//
//    var carbGoal: Double {
//        (goal?.carbValue ?? 0) + workoutsCarb
//    }
//    var proteinGoal: Double {
//        (goal?.proteinValue ?? 0) + workoutsProtein
//    }
//    var fatGoal: Double {
//        (goal?.fatValue ?? 0) + workoutsFat
//    }
//
//    //MARK: - Workouts
//    var workoutsEnergy: Double {
////        Double(Store.workoutsOnCurrentDate.reduce(0) { $0 + $1.energyBurned })
//        Double(Store.workouts(onDate: dateDate).reduce(0) { $0 + $1.energyBurned })
//    }
//
//    var workoutsFat: Double {
//        (workoutsFatRatio * workoutsEnergy)/9.0
//    }
//
//    var workoutsCarb: Double {
//        (workoutsCarbRatio * workoutsEnergy)/4.0
//    }
//    var workoutsProtein: Double {
//        (workoutsProteinRatio * workoutsEnergy)/4.0
//    }
//
//
//    var workoutsFatRatio: Double {
//        guard let goal = goal, distribution.addToFat else { return 0 }
//        switch distribution.macrosType {
//        case .fatOnly:
//            return 1.0
//        case .proteinAndFat:
//            if distribution.distributeWithGoalRatios {
//                return goal.fatRatio / (goal.proteinRatio + goal.fatRatio)
//            } else {
//                return 0.5
//            }
//        case .carbAndFat:
//            if distribution.distributeWithGoalRatios {
//                return goal.fatRatio / (goal.carbRatio + goal.fatRatio)
//            } else {
//                return 0.5
//            }
//        case .all:
//            if distribution.distributeWithGoalRatios {
//                return goal.fatRatio
//            } else {
//                return 1.0/3.0
//            }
//        default:
//            return 0
//        }
//    }
//
//    var workoutsProteinRatio: Double {
//        guard let goal = goal, distribution.addToProtein else { return 0 }
//        switch distribution.macrosType {
//        case .proteinOnly:
//            return 1.0
//        case .carbAndProtein:
//            if distribution.distributeWithGoalRatios {
//                return goal.proteinRatio / (goal.carbRatio + goal.proteinRatio)
//            } else {
//                return 0.5
//            }
//        case .proteinAndFat:
//            if distribution.distributeWithGoalRatios {
//                return goal.proteinRatio / (goal.proteinRatio + goal.fatRatio)
//            } else {
//                return 0.5
//            }
//        case .all:
//            if distribution.distributeWithGoalRatios {
//                return goal.proteinRatio
//            } else {
//                return 1.0/3.0
//            }
//        default:
//            return 0
//        }
//    }
//
//    var workoutsCarbRatio: Double {
//        guard let goal = goal, distribution.addToCarbohydrate else { return 0 }
//        switch distribution.macrosType {
//        case .carbOnly:
//            return 1.0
//        case .carbAndFat:
//            if distribution.distributeWithGoalRatios {
//                return goal.carbRatio / (goal.carbRatio + goal.fatRatio)
//            } else {
//                return 0.5
//            }
//        case .carbAndProtein:
//            if distribution.distributeWithGoalRatios {
//                return goal.carbRatio / (goal.carbRatio + goal.proteinRatio)
//            } else {
//                return 0.5
//            }
//        case .all:
//            if distribution.distributeWithGoalRatios {
//                return goal.carbRatio
//            } else {
//                return 1.0/3.0
//            }
//        default:
//            return 0
//        }
//    }
//
//    var workoutsCarbPercentage: Double {
//        workoutsCarbRatio * 100.0
//    }
//    var workoutsFatPercentage: Double {
//        workoutsFatRatio * 100.0
//    }
//    var workoutsProteinPercentage: Double {
//        workoutsProteinRatio * 100.0
//    }
//
//    var distribution: WorkoutsCaloriesDistribution {
//        workoutsCaloriesDistribution ?? Store.shared.defaultDistribution
//    }
//
////
////    //TODO: Use Distribution in these
////    var _workoutsCarb: Double {
////        guard let goal = goal, distribution.addToCarbohydrate else { return 0 }
////        let energy: CGFloat
////        switch distribution.macrosType {
////        case .carbOnly:
////            energy = workoutsEnergy
////        case .carbAndFat:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.carbRatio / (goal.carbRatio + goal.fatRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .carbAndProtein:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.carbRatio / (goal.carbRatio + goal.proteinRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .all:
////            if distribution.distributeWithGoalRatios {
////                energy = goal.carbRatio * workoutsEnergy
////            } else {
////                energy = (1.0/3.0) * workoutsEnergy
////            }
////        default:
////            energy = 0
////        }
////        return energy/4.0
////    }
////
////    var _workoutsProtein: Double {
////        guard let goal = goal, distribution.addToProtein else { return 0 }
////        let energy: CGFloat
////        switch distribution.macrosType {
////        case .proteinOnly:
////            energy = workoutsEnergy
////        case .carbAndProtein:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.proteinRatio / (goal.carbRatio + goal.proteinRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .proteinAndFat:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.proteinRatio / (goal.proteinRatio + goal.fatRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .all:
////            if distribution.distributeWithGoalRatios {
////                energy = goal.proteinRatio * workoutsEnergy
////            } else {
////                energy = (1.0/3.0) * workoutsEnergy
////            }
////        default:
////            energy = 0
////        }
////        return energy/4.0
////    }
////
////    var _workoutsFat: Double {
////        guard let goal = goal, distribution.addToFat else { return 0 }
////        let energy: CGFloat
////        switch distribution.macrosType {
////        case .fatOnly:
////            energy = workoutsEnergy
////        case .proteinAndFat:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.fatRatio / (goal.proteinRatio + goal.fatRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .carbAndFat:
////            if distribution.distributeWithGoalRatios {
////                energy = (goal.fatRatio / (goal.carbRatio + goal.fatRatio)) * workoutsEnergy
////            } else {
////                energy = 0.5 * workoutsEnergy
////            }
////        case .all:
////            if distribution.distributeWithGoalRatios {
////                energy = goal.fatRatio * workoutsEnergy
////            } else {
////                energy = (1.0/3.0) * workoutsEnergy
////            }
////        default:
////            energy = 0
////        }
////        return energy/9.0
////    }
//}
