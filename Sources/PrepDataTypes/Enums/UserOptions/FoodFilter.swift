import Foundation

public enum FoodFilter: Int, CaseIterable, Codable {
    case all
    case recipes
    case plates
    case foodsPrivate
    case foodsPublicWaitingForReview
    case foodsPublicApproved
    case foodsPublicRejected
    
    public var menuDescription: String {
        switch self {
        case .all:
            return "All"
        case .recipes:
            return "Recipes"
        case .plates:
            return "Plates"
        case .foodsPrivate:
            return "Private Foods"
        case .foodsPublicWaitingForReview:
            return "Waiting for Review"
        case .foodsPublicApproved:
            return "Approved"
        case .foodsPublicRejected:
            return "Rejected"
        }
    }
    
    public var pickerDescription: String {
        menuDescription
//            switch self {
//            case .foodsPublicWaitingForReview, .foodsPublicApproved, .foodsPublicRejected:
//                return "Public Foods: \(menuDescription)"
//            default:
//                return menuDescription
//            }
    }
    
    public var systemImage: String {
        switch self {
        case .all:
            return "line.3.horizontal.decrease.circle"
        case .recipes:
            return "frying.pan"
        case .plates:
            return "fork.knife"
        case .foodsPrivate:
            return "lock.shield.fill"
        case .foodsPublicWaitingForReview:
            return "questionmark.app.dashed"
        case .foodsPublicApproved:
            return "checkmark.seal"
        case .foodsPublicRejected:
            return "hand.thumbsdown"
        }
    }
    
    public static var publicFoodFilters: [FoodFilter] {
        [.foodsPublicApproved, .foodsPublicRejected, .foodsPublicWaitingForReview]
    }
    
    public static var combinationFilters: [FoodFilter] {
        [.plates, .recipes]
    }
}
