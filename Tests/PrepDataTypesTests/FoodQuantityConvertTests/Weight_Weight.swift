import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class FoodQuantityConvertTests: XCTestCase {
    
    //MARK: - Weight → Weight
    func testWeightToWeight() throws {
        for testCase in TestCases.Weight {
            for (weightUnit, expectation) in testCase.equivalentWeights {
                guard let result = testCase.quantity.convert(
                    to: .weight(weightUnit),
                    with: testCase.explicitVolumeUnits
                ) else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(
                    result.value.rounded(toPlaces: 2),
                    expectation.rounded(toPlaces: 2)
                )
            }
        }
    }
}


extension TestCases {
    static let Weight = [
        FoodQuantityTestCase(
            quantity: FoodQuantity(amount: 1, unit: .weight(.g), food: Food()),
            equivalentWeights: [
                .g : 1,
                .kg : 0.001,
                .mg : 1000,
                .oz : 0.03527396,
                .lb : 0.00220462
            ]
        ),
        FoodQuantityTestCase(
            quantity: FoodQuantity(amount: 30, unit: .weight(.oz), food: Food()),
            equivalentWeights: [
                .g : 850.486,
                .kg : 0.850486,
                .mg : 850485.69,
                .oz : 30,
                .lb : 1.87
            ]
        )
    ]
}
