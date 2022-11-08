import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    func testWeightToServings() throws {
        for testCase in TestCases.Weight_Serving {
            guard let result = testCase.quantity.convert(
                to: .serving,
                with: testCase.explicitVolumeUnits)
            else {
                XCTFail()
                return
            }
            XCTAssertEqual(
                result.value.rounded(toPlaces: 2),
                testCase.equivalentServing.rounded(toPlaces: 2)
            )
        }
    }
}

extension TestCases {
    static let Weight_Serving = [
        FoodQuantityTestCase(
            quantity: FoodQuantity(100, .g,
                food: Food(serving: .init(25, .g))
            ),
            equivalentServing: 4
        ),
    ]
}
