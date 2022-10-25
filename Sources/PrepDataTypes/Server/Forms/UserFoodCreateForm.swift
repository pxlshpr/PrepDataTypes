import Foundation

public struct UserFoodCreateForm: Codable {
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
}

public extension UserFoodCreateForm {
    
    func validate() async throws {
        /// `emoji` should be an emoji
        guard emoji.isSingleEmoji else {
            throw UserFoodCreateFormError.invalidEmoji
        }
        
        /// `amount` should have a valid `FoodValue`
        do {
            try amount.validate(within: self)
        } catch let error as FoodValueError {
            throw UserFoodCreateFormError.amountError(error)
        }
        
        /// `serving` should have a valid `FoodValue` if provided
        do {
            try serving?.validate(within: self)
        } catch let error as FoodValueError {
            throw UserFoodCreateFormError.servingError(error)
        }

        do {
            try nutrients.validate()
        } catch let error as FoodNutrientsError {
            throw UserFoodCreateFormError.nutrientsError(error)
        }

        do {
            try sizes.validate(within: self)
        } catch let error as FoodSizeError {
            throw UserFoodCreateFormError.sizesError(error)
        }
        
        do {
            try density?.validate()
        } catch let error as FoodDensityError {
            throw UserFoodCreateFormError.densityError(error)
        }
        
        if let linkUrl {
            guard linkUrl.isValidURL else {
                throw UserFoodCreateFormError.invalidLinkUrl
            }
        }
        if let prefilledUrl {
            guard prefilledUrl.isValidURL else {
                throw UserFoodCreateFormError.invalidPrefilledUrl
            }
        }
        
        guard status == .notPublished || status == .pendingReview else {
            throw UserFoodCreateFormError.initialStatusMustPendingReviewOrNotPublished
        }
    }
}

public enum UserFoodCreateFormError: Error {
    case invalidEmoji
    case amountError(FoodValueError)
    case servingError(FoodValueError)
    case nutrientsError(FoodNutrientsError)
    case sizesError(FoodSizeError)
    case densityError(FoodDensityError)
    case invalidLinkUrl
    case invalidPrefilledUrl
    case duplicateBarcodes
    case existingBarcode
    case initialStatusMustPendingReviewOrNotPublished
    case nonExistentUser
    case nonExistentSpawnedUserFood
    case nonExistentSpawnedDatabaseFood
    case bothSpawnedUserAndDatabaseFoodsWereProvided
}
