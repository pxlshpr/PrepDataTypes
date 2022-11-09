import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    func test_Size_Serving() throws {
        for testCase in TestCases.Size_Serving {
            
            let result = testCase.quantity.convert(to: .serving)
            
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
    static let Size_Serving = [
        
        /// volume-based serving
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                1, "bottle",
                Food(
                    serving: .init(100, .ml),
                    sizes: [
                        .init(1.5, "bottle", .init(335, .ml)),
                    ]
                )
            )!,
            equivalentServing: 0.44776119
        ),

//        /// volume-based serving with non-default amount (shouldn't make a difference)
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                1.05, .tablespoonUS, /// 14.79
//                Food(
//                    amount: .init(2.5), /// indicates 2.5 servings
//                    serving: .init(2, .cupImperial) /// 284.13 mL
//                )
//            ),
//            equivalentServing: 0.02732816
//        ),
//
//        /// weight-size-size-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                350, .ml,
//                Food(
//                serving: .init(0.2, "box"),
//                density: .init(100, .g, 1, .cupJapanTraditional), /// 180.39 mL
//                sizes: [
//                    .init(2, "bottle", .init(4, .oz)),
//                    .init(1.5, "pack", .init(3, "bottle")),
//                    .init(0.5, "box", .init(2, "pack"))
//                ]
//            )),
//            equivalentServing: 2.13874854
//        ),
    ]
}
