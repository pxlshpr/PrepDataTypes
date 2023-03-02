import Foundation
import SwiftSugar

/// This is a summarised version of a `FoodItem` to be placed inside a `Meal` object
/// It is stripped off the relation back to the `Meal` so as to not clear a cyclical recursion error,
/// in addition to not having the `syncStatus`, `updatedAt`, `deletedAt` metadata.
/// This is only to be used as a child of a `Meal` to be used in the UI.
public struct MealItem: Identifiable, Hashable, Codable, Equatable {
    public var id: UUID
    public var food: Food
    public var amount: FoodValue
    public var markedAsEatenAt: Double?
    public var sortPosition: Int

    public var isSoftDeleted: Bool
    public var badgeWidth: CGFloat
    public var energyInKcal: Double
    
    public var mealId: UUID?

    public init(
        id: UUID = UUID(),
        food: Food,
        amount: FoodValue,
        markedAsEatenAt: Double? = nil,
        sortPosition: Int = 0,
        isSoftDeleted: Bool,
        badgeWidth: CGFloat = 0,
        energyInKcal: Double,
        mealId: UUID?
    ) {
        self.id = id
        self.food = food
        self.amount = amount
        self.markedAsEatenAt = markedAsEatenAt
        self.sortPosition = sortPosition
        self.isSoftDeleted = isSoftDeleted
        self.badgeWidth = badgeWidth
        self.energyInKcal = energyInKcal
        self.mealId = mealId
    }
}

public extension MealItem {
    init(from foodItem: FoodItem) {
//        cprint(foodItem)
        self.init(
            id: foodItem.id,
            food: foodItem.food,
            amount: foodItem.amount,
            markedAsEatenAt: foodItem.markedAsEatenAt,
            sortPosition: foodItem.sortPosition,
            isSoftDeleted: foodItem.deletedAt != nil && foodItem.deletedAt! > 0,
            energyInKcal: foodItem.scaledValueForEnergyInKcal,
            mealId: foodItem.meal?.id
        )
    }
}

public extension MealItem {
    var isCompleted: Bool {
        markedAsEatenAt != nil && markedAsEatenAt! > 0
    }
    
    var description: String {
        "\(amount.value.cleanAmount) \(amount.unitDescription(sizes: food.info.sizes))"
    }
    
    /// Used for `FoodLabel`
    var microsDict: [NutrientType : FoodLabelValue] {
        var dict: [NutrientType : FoodLabelValue] = [:]
        for nutrient in food.info.nutrients.micros {
            guard let nutrientType = nutrient.nutrientType
            else { continue }
            dict[nutrientType] = FoodLabelValue(
                amount:
                    nutrient.value * nutrientScaleFactor,
                unit:
                    nutrient.nutrientUnit.foodLabelUnit
                    ?? nutrientType.defaultUnit.foodLabelUnit
                    ?? .g
            )
        }
        return dict
    }
}

extension NutrientType {
    var defaultUnit: NutrientUnit {
        units.first ?? .g
    }
}


public struct IngredientItem: Identifiable, Hashable, Codable, Equatable {
    public var id: UUID
    public var food: Food
    public var amount: FoodValue
    public var sortPosition: Int
    public var isSoftDeleted: Bool
    public var badgeWidth: CGFloat
    public var energyInKcal: Double
    
    public var parentFoodId: UUID?
    
    public init(
        id: UUID = UUID(),
        food: Food,
        amount: FoodValue,
        sortPosition: Int = 0,
        isSoftDeleted: Bool,
        badgeWidth: CGFloat = 0,
        energyInKcal: Double,
        parentFoodId: UUID?
    ) {
        self.id = id
        self.food = food
        self.amount = amount
        self.sortPosition = sortPosition
        self.isSoftDeleted = isSoftDeleted
        self.badgeWidth = badgeWidth
        self.energyInKcal = energyInKcal
        self.parentFoodId = parentFoodId
    }
}

public extension IngredientItem {
    var microsDict: [NutrientType : FoodLabelValue] {
        var dict: [NutrientType : FoodLabelValue] = [:]
        for nutrient in food.info.nutrients.micros {
            guard let nutrientType = nutrient.nutrientType
            else { continue }
            dict[nutrientType] = FoodLabelValue(
                amount:
                    nutrient.value * nutrientScaleFactor,
                unit:
                    nutrient.nutrientUnit.foodLabelUnit
                    ?? nutrientType.defaultUnit.foodLabelUnit
                    ?? .g
            )
        }
        return dict
    }
}


public extension IngredientItem {
    var quantityDescription: String {
        amount.description(with: food)
    }
}
