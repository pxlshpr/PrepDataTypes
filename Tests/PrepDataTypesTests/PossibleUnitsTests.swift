import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class PossibleUnitsTests: XCTestCase {
    
    func _testPossibleUnits() throws {
        let wheyProtein = Food(
            serving: .init(1, "scoop"),
            sizes: [
                .init(1, "scoop", .init(30.4, .g)),
                .init(1, "container", .init(74, "scoop"))
            ]
        )
        
        let quantity = FoodQuantity(30.4, .g, food: wheyProtein)
        
        let possibleQuantities = quantity.equivalentQuantities()

        for quantity in possibleQuantities {
            print(quantity.description)
        }
    }
}


