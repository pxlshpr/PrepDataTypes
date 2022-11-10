import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    func test_Serving_Size() throws {
        for testCase in TestCases.Serving_Size {

            for sizeTest in testCase.equivalentSizes {

                let volumePrefixUnit = sizeTest.0
                let sizeId = sizeTest.1
                let expectedValue = sizeTest.2

                guard let foodSize = testCase.quantity.food.size(for: sizeId),
                      let size = FoodQuantity.Size(foodSize: foodSize, in: testCase.quantity.food),
                      let result = testCase.quantity.convert(to: .size(size, volumePrefixUnit))
                else {
                    XCTFail()
                    return
                }
                assertEqual(result.value, expectedValue)
            }
        }
    }
}

extension TestCases {
    static let Serving_Size = [

        /// weight
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                3,
                Food(
                    serving: .init(8, .g),
                    sizes: [
                        .init(3, "ball", .init(12, .g)),
                        .init(1.5, "box", .init(30, "ball")),
                        .init(5, "carton", .init(15, "box")),
                    ]
                )
            ),
            equivalentSizes: [
                (nil, "ball", 6),
                (nil, "box", 0.3),
                (nil, "carton", 0.1)
            ]
        ),

        /// weight based sizes
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                3,
                Food(
                    serving: .init(2, "ball"),
                    sizes: [
                        .init(3, "ball", .init(12, .g)),
                        .init(1.5, "box", .init(30, "ball")),
                        .init(5, "carton", .init(15, "box")),
                    ]
                )
            ),
            equivalentSizes: [
                (nil, "ball", 6),
                (nil, "box", 0.3),
                (nil, "carton", 0.1)
            ]
        ),

        /// now bring in the rest from `FoodServingsTests`
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                2,
                Food(
                    serving: .init(1, .cupJapanTraditional, "chopped5"), /// 180.39 mL
                    sizes: [
                        .init(2, .fluidOunceUSNutritionLabeling, "chopped", .init(370, .g)), /// 30 mL
                        .init(1.5, "packet", .init(3, "chopped5")), /// 2 floz
                        .init(5, "carton", .init(15, "packet")) /// 3 packets
                    ]
                )
            ),
            equivalentSizes: [
                (.cupJapanTraditional, "chopped5", 2),
                (.fluidOunceUSNutritionLabeling, "chopped5", 12.026),
                (nil, "carton", 2.00433334)
            ]
        ),
        
        /// spinach
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                1,
                Food(
                    mockName: "Spinach",
                    serving: .init(1, .cupMetric),
                    density: .init(30, .g, 1, .cupMetric),
                    sizes: [
                        .init(1, "leaf", .init(10, .g)),
                    ]
                )
            ),
            equivalentSizes: [
                (nil, "leaf", 3),
            ]
        ),
    ]
}
