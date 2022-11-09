//import XCTest
//@testable import PrepDataTypes
//@testable import SwiftSugar
//
//extension FoodQuantityConvertTests {
//    func test_Serving_Size() throws {
//        for testCase in TestCases.Serving_Size {
//
//            for sizeTest in testCase.equivalentSizes {
//
//                let volumePrefixUnit = sizeTest.0
//                let sizeId = sizeTest.1
//                let expectedValue = sizeTest.2
//
//                guard let foodSize = testCase.quantity.food.size(for: sizeId),
//                      let size = FoodQuantity.Size(foodSize: foodSize, in: testCase.quantity.food),
//                      let result = testCase.quantity.convert(to: .size(size, volumePrefixUnit))
//                else {
//                    XCTFail()
//                    return
//                }
//                assertEqual(result.value, expectedValue)
//            }
//        }
//    }
//}
//
//extension TestCases {
//    static let Serving_Size = [
//
//        /// weight based sizes
////        FoodQuantityTestCase(
////            quantity: FoodQuantity(
////                3,
////                Food(
////                    serving: .init(2, "ball"),
////                    sizes: [
////                        .init(3, "ball", .init(12, .g)),
////                        .init(1.5, "box", .init(30, "ball")),
////                        .init(5, "carton", .init(15, "box")),
////                    ]
////                )
////            ),
////            equivalentSizes: [
////                (nil, "ball", 6),
////                (nil, "box", 0.15),
////                (nil, "carton", 0.05)
////            ]
////        ),
//
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                3,
//                Food(
//                    serving: .init(8, .g),
//                    sizes: [
//                        .init(3, "ball", .init(12, .g)),
//                        .init(1.5, "box", .init(30, "ball")),
//                        .init(5, "carton", .init(15, "box")),
//                    ]
//                )
//            ),
//            equivalentSizes: [
//                (nil, "ball", 6),
//                (nil, "box", 0.15),
//                (nil, "carton", 0.05)
//            ]
//        ),
//    ]
//}
