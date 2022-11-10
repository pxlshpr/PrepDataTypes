import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class PossibleUnitsTests: XCTestCase {
    
    func testPossibleUnitsWithout() throws {
        
        let food = Food(
            mockName: "Carrot",
            serving: .init(1, .cupUSLegal, "chopped4"), /// 240 mL
            sizes: [
                .init(0.5, .cupUSLegal, "chopped", .init(135, .g)), /// 240 mL
                .init(2, "medium", .init(100, .g)),
            ]
        )
        
        let quantity = FoodQuantity(1, food)
        guard let choppedUS = food.quantitySize(for: "chopped4") else { XCTFail(); return }
        let choppedMetricUnit = FoodQuantity.Unit.size(choppedUS, .cupMetric)
        let value = quantity.convert(to: choppedMetricUnit)
        
//        let possibleUnits = quantity.food.possibleUnits(without: quantity.unit, using: .defaultUnits)
//
//        for possibleUnit in possibleUnits {
//            print(possibleUnit.shortDescription)
//        }
//
//        let equivalents = quantity.equivalentQuantities(using: .defaultUnits)
//        let equivalents = possibleUnits
//            .compactMap { convert(to: $0) }

        print("We here")
    }
}
