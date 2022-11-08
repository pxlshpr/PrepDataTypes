import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

func assertEqual(toPlaces places: Int = 2, _ double: Double, _ other: Double) {
    XCTAssertEqual(double.rounded(toPlaces: places), other.rounded(toPlaces: places))
}

extension FoodQuantityConvertTests {
    func testWeightToServings() throws {
        for testCase in TestCases.Weight_Serving {
            let result = testCase.quantity.convert(
                to: .serving,
                with: testCase.explicitVolumeUnits
            )
            
            if let expectedServing = testCase.equivalentServing {
                guard let result else {
                    XCTFail()
                    return
                }
                assertEqual(result.value, expectedServing)
            } else {
                XCTAssertNil(result)
            }
        }
    }
}

extension TestCases {
    static let Weight_Serving = [
        
        /// Weight-based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                100, .g,
//                food: Food(serving: .init(25, .g))
//            ),
//            equivalentServing: 4
//        ),
//
//        /// Volume-based serving (without density)
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                100, .g,
//                food: Food(serving: .init(25, .cupMetric))
//            ),
//            equivalentServing: nil
//        ),
//
//        /// Volume-based serving (with density)
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                100, .g,
//                food: Food(
//                    serving: .init(25, .tablespoonUS),      /// 14.79 mL  x 25 = 369.75 mL
//                    density: .init(100, .g, 2, .cupMetric)  /// 250 mL
//                )
//            ),
//            equivalentServing: 1.35226504
//        ),
//
//        /// Size (weight) based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                12, .g,
//                food: Food(
//                    serving: .init(3, "ball"),
//                    sizes: [
//                        .init(name: "ball", quantity: 3, value: .init(12, .g))
//                    ]
//                )
//            ),
//            equivalentServing: 1
//        ),
//
//        /// volume-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                120, .g,
//                food: Food(
//                    serving: .init(1, "bottle"),
//                    density: .init(100, .g, 150, .ml),
//                    sizes: [
//                        .init(name: "bottle", quantity: 2, value: .init(4, .cupMetric))
//                    ]
//                )
//            ),
//            equivalentServing: 0.36
//        ),
//
//        /// weight-size-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                15, .g,
//                food: Food(
//                    serving: .init(0.5, "box"),
//                    sizes: [
//                        .init(name: "ball", quantity: 3, value: .init(12, .g)),
//                        .init(name: "box", quantity: 1, value: .init(24, "ball")),
//                    ]
//                )
//            ),
//            equivalentServing: 0.3125
//        ),
//
//        /// Size (size (volume)) based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                100, .g,
//                food: Food(serving: .init(25, .g))
//            ),
//            equivalentServing: 4
//        ),
//
        /// Size (size (size (weight))) based serving
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                150, .g,
                food: Food(
                    serving: .init(1.5, "carton"),
                    sizes: [
                        .init(name: "ball", quantity: 3, value: .init(12, .g)),
                        .init(name: "box", quantity: 1.5, value: .init(30, "ball")),
                        .init(name: "carton", quantity: 5, value: .init(15, "box")),
                    ]
                )
            ),
            equivalentServing: 0.41666667
        ),
//
//        /// Size (size (size (volume))) based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                100, .g,
//                food: Food(serving: .init(25, .g))
//            ),
//            equivalentServing: 4
//        ),

    ]
}
