import Foundation

public struct UserFoodData: Codable {
    public var name: String
    public var emoji: String
    public var detail: String?
    public var brand: String?
    public var amount: FoodValue
    public var serving: FoodValue?
    public var nutrients: FoodNutrients
    public var sizes: [FoodSize]
    public var density: FoodDensity?
    public var linkUrl: String?
    public var prefilledUrl: String?
    public var imageIds: [UUID]?
    public var status: UserFoodStatus

    public var spawnedUserFoodId: UUID?
    public var spawnedDatabaseFoodId: UUID?
    public var userId: UUID

    public var barcodes: [FoodBarcode]
    
    public init(name: String, emoji: String, detail: String? = nil, brand: String? = nil, amount: FoodValue, serving: FoodValue? = nil, nutrients: FoodNutrients, sizes: [FoodSize], density: FoodDensity? = nil, linkUrl: String? = nil, prefilledUrl: String? = nil, imageIds: [UUID]? = nil, status: UserFoodStatus, spawnedUserFoodId: UUID? = nil, spawnedDatabaseFoodId: UUID? = nil, userId: UUID, barcodes: [FoodBarcode]) {
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.amount = amount
        self.serving = serving
        self.nutrients = nutrients
        self.sizes = sizes
        self.density = density
        self.linkUrl = linkUrl
        self.prefilledUrl = prefilledUrl
        self.imageIds = imageIds
        self.status = status
        self.spawnedUserFoodId = spawnedUserFoodId
        self.spawnedDatabaseFoodId = spawnedDatabaseFoodId
        self.userId = userId
        self.barcodes = barcodes
    }
}

public extension UserFoodData {
    
    func validate() throws -> Bool {
        guard !name.isEmpty else {
            throw UserFoodDataError.nameIsEmpty
        }
        /// `emoji` should be an emoji
        guard emoji.isSingleEmoji else {
            throw UserFoodDataError.invalidEmoji
        }
        
        /// `amount` should have a valid `FoodValue`
        do {
            try amount.validate(within: self)
        } catch let error as FoodValueError {
            throw UserFoodDataError.amountError(error)
        }
        
        /// `serving` should have a valid `FoodValue` if provided
        do {
            try serving?.validate(within: self)
        } catch let error as FoodValueError {
            throw UserFoodDataError.servingError(error)
        }

        do {
            try nutrients.validate()
        } catch let error as FoodNutrientsError {
            throw UserFoodDataError.nutrientsError(error)
        }

        do {
            try sizes.validate(within: self)
        } catch let error as FoodSizeError {
            throw UserFoodDataError.sizesError(error)
        }
        
        do {
            try density?.validate()
        } catch let error as FoodDensityError {
            throw UserFoodDataError.densityError(error)
        }
        
        if let linkUrl {
            guard linkUrl.isValidUrl else {
                throw UserFoodDataError.invalidLinkUrl
            }
        }
        if let prefilledUrl {
            guard prefilledUrl.isValidUrl else {
                throw UserFoodDataError.invalidPrefilledUrl
            }
        }
        
        guard status == .notPublished || status == .pendingReview else {
            throw UserFoodDataError.initialStatusMustPendingReviewOrNotPublished
        }
        
        return true
    }
}

public enum UserFoodDataError: Error {
    case nameIsEmpty
    case invalidEmoji
    case amountError(FoodValueError)
    case servingError(FoodValueError)
    case nutrientsError(FoodNutrientsError)
    case sizesError(FoodSizeError)
    case densityError(FoodDensityError)
    case invalidLinkUrl
    case invalidPrefilledUrl
    case initialStatusMustPendingReviewOrNotPublished
    case nonExistentUser
    case nonExistentSpawnedUserFood
    case nonExistentSpawnedDatabaseFood
    case bothSpawnedUserAndDatabaseFoodsWereProvided
}
