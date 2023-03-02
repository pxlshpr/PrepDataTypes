import Foundation

/// This is a summarised version of a Meal to be placed inside a `Day` object
/// It is stripped off the relation back to the `Day` so as to not clear a cyclical recursion error,
/// in addition to not having the `syncStatus`, `updatedAt`, `deletedAt` metadata.
/// This is only to be used as a child of a `Day` to be used in the UI.
public struct DayMeal: Identifiable, Hashable, Codable {
    public let id: UUID
    public var name: String
    public var time: Double
    public var markedAsEatenAt: Double?
    public var goalSet: GoalSet?
    public var foodItems: [MealItem]

    
    public var badgeWidth: CGFloat

    public init(
        id: UUID = UUID(),
        name: String,
        time: Double,
        markedAsEatenAt: Double? = nil,
        goalSet: GoalSet? = nil,
        foodItems: [MealItem] = [],
        badgeWidth: CGFloat = 0
    ) {
        self.id = id
        self.name = name
        self.time = time
        self.markedAsEatenAt = markedAsEatenAt
        self.goalSet = goalSet
        self.foodItems = foodItems.sorted(by: { $0.sortPosition < $1.sortPosition })
        self.badgeWidth = badgeWidth
    }
}

#if os(iOS)

public extension DayMeal {
    init(from meal: Meal) {
        self.init(
            id: meal.id,
            name: meal.name,
            time: meal.time,
            markedAsEatenAt: meal.markedAsEatenAt,
            goalSet: meal.goalSet,
            foodItems: meal.foodItems.sorted(by: { $0.sortPosition < $1.sortPosition }),
            badgeWidth: meal.badgeWidth ?? 0
        )
    }
}

public extension Meal {
    var macrosIndicatorWidth: CGFloat {
        day.macrosIndicatorWidth(for: energyValueInKcal)
    }
    
    var energyValueInKcal: Double {
        foodItems.reduce(0) {
            $0 + $1.scaledValueForEnergyInKcal
        }
    }
}

public extension Day {
    func macrosIndicatorWidth(for energyInKcal: CGFloat) -> CGFloat {
//        calculateMacrosIndicatorWidth(
//            for: energyInKcal,
//            largest: largestEnergyInKcal,
//            smallest: smallestEnergyInKcal
//        )
        calculateMacrosIndicatorWidth(
            for: energyInKcal,
            within: energyValuesInKcalDecreasing
        )
    }
    
    var energyValuesInKcalDecreasing: [Double] {
        meals
            .filter { !$0.foodItems.isEmpty }
            .map { $0.energyValueInKcal }
            .sorted { $0 > $1 }
    }
    var largestEnergyInKcal: Double {
        energyValuesInKcalDecreasing.first ?? 0
    }
    
    var smallestEnergyInKcal: Double {
        energyValuesInKcalDecreasing.last ?? 0
    }
}

import SwiftUI

public let DefaultBadgeWidth: CGFloat = 30.0

public func calculateMacrosIndicatorWidth(
    for value: Double,
    within values: [Double],
    maxWidth: CGFloat? = nil
) -> CGFloat {
    let sorted = values
        .filter { $0 > 0 }
        .sorted { $0 > $1 }
    guard let largest = sorted.first,
          let smallest = sorted.last
    else { return DefaultBadgeWidth }
    
    return calculateMacrosIndicatorWidth(
        for: value,
        largest: largest,
        smallest: smallest,
        maxWidth: maxWidth
    )
}

public func calculateMacrosIndicatorWidth(
    for value: Double,
    largest: Double,
    smallest: Double,
    maxWidth: CGFloat? = nil
) -> CGFloat {
    
    let maxWidth = maxWidth ?? (0.34883721 * UIScreen.main.bounds.width)
    
//    let DefaultWidth: CGFloat = 30

    let min = DefaultBadgeWidth
    let max: CGFloat = maxWidth
    
    guard largest > 0, smallest > 0, value <= largest, value >= smallest else {
        return DefaultBadgeWidth
    }
    
    /// First try and scale values such that smallest value gets the DefaultWidth and everything else scales accordingly
    /// But first see if this results in the largest value crossing the MaxWidth, and if so
    guard (largest/smallest) * min <= max else {
        /// scale values such that largest value gets the MaxWidth and everything else scales accordingly
        let percent = value/largest
        let width = percent * max
        return width
    }
    
    let percent = value/smallest
    let width = percent * min
    return width
}

#endif
