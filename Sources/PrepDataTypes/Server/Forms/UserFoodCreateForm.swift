import Foundation

public struct UserFoodCreateForm: Codable {
    public var id: UUID
    public var foodType: FoodType
    public var name: String
    public var emoji: String
    public var detail: String?
    public var brand: String?
    public var publishStatus: UserFoodPublishStatus
    public var info: UserFoodInfo
    
    public init(
        id: UUID,
        foodType: FoodType = .rawFood,
        name: String,
        emoji: String,
        detail: String? = nil,
        brand: String? = nil,
        publishStatus: UserFoodPublishStatus,
        info: UserFoodInfo
    ) {
        self.id = id
        self.foodType = foodType
        self.name = name
        self.emoji = emoji
        self.detail = detail
        self.brand = brand
        self.publishStatus = publishStatus
        self.info = info
    }
}

public extension UserFoodCreateForm {
    
    func validate() throws -> Bool {
        guard !name.isEmpty else {
            throw UserFoodDataError.nameIsEmpty
        }
        /// `emoji` should be an emoji
        guard emoji.isSingleEmoji else {
            throw UserFoodDataError.invalidEmoji
        }
        
        
        guard publishStatus == .hidden || publishStatus == .pendingReview else {
            throw UserFoodDataError.initialStatusNotHiddenOrPendingReview
        }
        
        return true
    }
}

public extension UserFoodInfo {
    func validate() throws -> Bool {
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
    case initialStatusNotHiddenOrPendingReview
    case nonExistentUser
    case nonExistentSpawnedUserFood
    case nonExistentSpawnedPresetFood
    case bothSpawnedUserFoodAndPresetFoodWasProvided
}
