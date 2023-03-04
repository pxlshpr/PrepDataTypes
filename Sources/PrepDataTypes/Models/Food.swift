import Foundation

public struct Food: Identifiable, Hashable, Codable {
    public let id: UUID
    public let type: FoodType
    public var name: String
    public let emoji: String
    public var detail: String?
    public var brand: String?
    public let numberOfTimesConsumedGlobally: Int
    public let numberOfTimesConsumed: Int
    public let lastUsedAt: Double?
    public let firstUsedAt: Double?
    public let info: FoodInfo

    /// `UserFood` specific
    public let publishStatus: UserFoodPublishStatus?
    public var jsonSyncStatus: SyncStatus
    public let childrenFoods: [Food]? //TODO: Use compact version here if we'll get cyclical errors
    public let ingredientItems: [IngredientItem]?

    /// `PresetFood` specific
    public let dataset: FoodDataset?

    public let barcodes: [Barcode]?
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(id: UUID, type: FoodType, name: String, emoji: String, detail: String?, brand: String?, numberOfTimesConsumedGlobally: Int, numberOfTimesConsumed: Int, lastUsedAt: Double?, firstUsedAt: Double?, info: FoodInfo, publishStatus: UserFoodPublishStatus?, jsonSyncStatus: SyncStatus, childrenFoods: [Food]?, ingredientItems: [IngredientItem]?, dataset: FoodDataset?, barcodes: [Barcode]?, syncStatus: SyncStatus, updatedAt: Double, deletedAt: Double? = nil) {
        self.id = id
        self.type = type
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.numberOfTimesConsumedGlobally = numberOfTimesConsumedGlobally
        self.numberOfTimesConsumed = numberOfTimesConsumed
        self.lastUsedAt = lastUsedAt
        self.firstUsedAt = firstUsedAt
        self.info = info
        self.publishStatus = publishStatus
        self.jsonSyncStatus = jsonSyncStatus
        self.childrenFoods = childrenFoods
        self.ingredientItems = ingredientItems
        self.dataset = dataset
        self.barcodes = barcodes
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

public extension Food {
    var isDeleted: Bool {
        deletedAt != nil && deletedAt! > 0
    }
}

public extension Food {
    var primaryMacro: Macro {
        let carb = info.nutrients.carb
        let fat = info.nutrients.fat
        let protein = info.nutrients.protein
        let carbCalories = carb * 4.0
        let fatCalories = fat * 9.0
        let proteinCalories = protein * 4.0
        if carbCalories > fatCalories && carbCalories > proteinCalories {
            return .carb
        }
        if fatCalories > carbCalories && fatCalories > proteinCalories {
            return .fat
        }
//        if proteinCalories > fatCalories && proteinCalories > carbCalories {
//            return .protein
//        }
        return .protein
    }
    
    var hasDetail: Bool {
        detail != nil && !detail!.isEmpty
    }
    var hasBrand: Bool {
        brand != nil && !brand!.isEmpty
    }

    var hasDetails: Bool {
        hasDetail || hasBrand
    }
}

public extension Food {
    var energyBySummatingMacros: Double {
        (info.nutrients.carb * KcalsPerGramOfCarb)
        + (info.nutrients.fat * KcalsPerGramOfFat)
        + (info.nutrients.protein * KcalsPerGramOfProtein)
    }
    
    var carbPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.carb * KcalsPerGramOfCarb) / energyBySummatingMacros
    }
    var fatPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.fat * KcalsPerGramOfFat) / energyBySummatingMacros
    }
    var proteinPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.protein * KcalsPerGramOfProtein) / energyBySummatingMacros
    }
}

public extension Food {
    var ingredientFood: IngredientFood {
        IngredientFood(
            id: id,
            type: type,
            name: name,
            emoji: emoji,
            detail: detail,
            brand: brand,
            numberOfTimesConsumedGlobally: numberOfTimesConsumedGlobally,
            numberOfTimesConsumed: numberOfTimesConsumed,
            lastUsedAt: lastUsedAt,
            firstUsedAt: firstUsedAt,
            info: info,
            publishStatus: publishStatus,
            dataset: dataset,
            barcodes: barcodes
        )
    }
}

public extension IngredientFood {
    /// This 'detached' food is essentially a `Food` created from an `IngredientFood`, to use in places where a `Food`
    /// is required and cannot be swapped in with an `IngredientFood`.
    ///
    /// Since `IngredientFood` is a stripped-out version of `Food` to begin with—this re-creates that same `Food`, but
    /// with only the stripped out data. Things like the `ingredientItems`, and metadata like `syncStatus` and timestamps
    /// are not included.
    var detachedFood: Food {
        Food(
            id: id,
            type: type,
            name: name,
            emoji: emoji,
            detail: detail,
            brand: brand,
            numberOfTimesConsumedGlobally: numberOfTimesConsumedGlobally,
            numberOfTimesConsumed: numberOfTimesConsumed,
            lastUsedAt: lastUsedAt,
            firstUsedAt: firstUsedAt,
            info: info,
            publishStatus: publishStatus,
            jsonSyncStatus: .synced,
            childrenFoods: nil,
            ingredientItems: nil,
            dataset: dataset,
            barcodes: barcodes,
            syncStatus: .synced,
            updatedAt: 0
        )
    }
}

//MARK: - IngredientFood

public struct IngredientFood: Identifiable, Hashable, Codable {
    public let id: UUID
    public let type: FoodType
    public var name: String
    public let emoji: String
    public var detail: String?
    public var brand: String?
    public let numberOfTimesConsumedGlobally: Int
    public let numberOfTimesConsumed: Int
    public let lastUsedAt: Double?
    public let firstUsedAt: Double?
    public let info: FoodInfo

    public let publishStatus: UserFoodPublishStatus?
    public let dataset: FoodDataset?
    public let barcodes: [Barcode]?
    
    public init(
        id: UUID,
        type: FoodType,
        name: String,
        emoji: String,
        detail: String?,
        brand: String?,
        numberOfTimesConsumedGlobally: Int,
        numberOfTimesConsumed: Int,
        lastUsedAt: Double?,
        firstUsedAt: Double?,
        info: FoodInfo,
        publishStatus: UserFoodPublishStatus?,
        dataset: FoodDataset?,
        barcodes: [Barcode]?
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.numberOfTimesConsumedGlobally = numberOfTimesConsumedGlobally
        self.numberOfTimesConsumed = numberOfTimesConsumed
        self.lastUsedAt = lastUsedAt
        self.firstUsedAt = firstUsedAt
        self.info = info
        self.publishStatus = publishStatus
        self.dataset = dataset
        self.barcodes = barcodes
    }
}

public extension IngredientFood {
    var primaryMacro: Macro {
        let carb = info.nutrients.carb
        let fat = info.nutrients.fat
        let protein = info.nutrients.protein
        let carbCalories = carb * 4.0
        let fatCalories = fat * 9.0
        let proteinCalories = protein * 4.0
        if carbCalories > fatCalories && carbCalories > proteinCalories {
            return .carb
        }
        if fatCalories > carbCalories && fatCalories > proteinCalories {
            return .fat
        }
        return .protein
    }
    
    var hasDetail: Bool {
        detail != nil && !detail!.isEmpty
    }
    var hasBrand: Bool {
        brand != nil && !brand!.isEmpty
    }

    var hasDetails: Bool {
        hasDetail || hasBrand
    }
}

public extension IngredientFood {
    var energyBySummatingMacros: Double {
        (info.nutrients.carb * KcalsPerGramOfCarb)
        + (info.nutrients.fat * KcalsPerGramOfFat)
        + (info.nutrients.protein * KcalsPerGramOfProtein)
    }
    
    var carbPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.carb * KcalsPerGramOfCarb) / energyBySummatingMacros
    }
    var fatPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.fat * KcalsPerGramOfFat) / energyBySummatingMacros
    }
    var proteinPortion: Double {
        guard energyBySummatingMacros > 0 else { return 0 }
        return (info.nutrients.protein * KcalsPerGramOfProtein) / energyBySummatingMacros
    }
}
