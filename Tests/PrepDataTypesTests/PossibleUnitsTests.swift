import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class PossibleUnitsTests: XCTestCase {
    
    func testPossibleUnitsWithout() throws {
        
        let quantity = FoodQuantity(
            1.5, .cupMetric, "chopped4",
            Food(
                mockName: "Carrot",
                sizes: [
                    .init(0.5, .cupUSLegal, "chopped", .init(135, .g)),
                    .init(2, "medium", .init(100, .g)),
                ]
            )
        )!
        
        let choppedSize = quantity.food.quantitySize(for: "chopped4")!
//        let unit = FoodQuantity.Unit.size(choppedSize, .chop)
        
        let possibleUnits = quantity.food.possibleUnits(
            without: .size(choppedSize, nil),
            using: .defaultUnits
        )

        for possibleUnit in possibleUnits {
            print(possibleUnit.shortDescription)
        }
        print("We here")
    }
}
