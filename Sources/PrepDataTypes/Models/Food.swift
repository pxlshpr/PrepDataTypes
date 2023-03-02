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

    /// `PresetFood` specific
    public let dataset: FoodDataset?

    public let barcodes: [Barcode]?
    
    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(id: UUID, type: FoodType, name: String, emoji: String, detail: String?, brand: String?, numberOfTimesConsumedGlobally: Int, numberOfTimesConsumed: Int, lastUsedAt: Double?, firstUsedAt: Double?, info: FoodInfo, publishStatus: UserFoodPublishStatus?, jsonSyncStatus: SyncStatus, childrenFoods: [Food]?, dataset: FoodDataset?, barcodes: [Barcode]?, syncStatus: SyncStatus, updatedAt: Double, deletedAt: Double? = nil) {
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

