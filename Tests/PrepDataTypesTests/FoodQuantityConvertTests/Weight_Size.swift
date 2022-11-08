import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    func _testWeightToSize() throws {
        for testCase in TestCases.Weight_Size {
            
            for (sizeId, expectedValue) in testCase.equivalentSizes {
                guard let foodSize = testCase.quantity.food.size(for: sizeId),
                      let size = FoodQuantity.Size(foodSize: foodSize, in: testCase.quantity.food),
                      let result = testCase.quantity.convert(to: .size(size, nil))
                else {
                    XCTFail()
                    return
                }
                assertEqual(result.value, expectedValue.0)
                XCTAssertEqual(result.unit.sizeVolumePrefixExplicitUnit, expectedValue.1)
            }
        }
    }
}

extension TestCases {
    static let Weight_Size = [

        /// weight-size-size-size based serving
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
            equivalentSizes: [
                "ball" : (37.5, nil),
                "box" : (1.875, nil),
                "carton" : (0.625, nil)
            ]
        ),
        
        /// test amount too in all others?
        
        /// vps-based serving
        /// something like ...
//        equivalentVolumePrefixedSizes: [
//            "ball" : (1, .cupMetric),
//            "box" : (1, .cupMetric),
//            "carton" : (1, .cupMetric)
//        ]

        /// volume-size-size-size based serving
        
        /// serving-based serving (should be nil)

//        /// weight-size based serving
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
//        /// volume-size-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                120, .g,
//                food: Food(
//                    serving: .init(0.75, "pack"),
//                    density: .init(100, .g, 1, .cupJapanTraditional), /// 180.39 mL
//                    sizes: [
//                        .init(name: "bottle", quantity: 2, value: .init(4, .cupMetric)), /// 250 mL
//                        .init(name: "pack", quantity: 1.5, value: .init(3, "bottle"))
//                    ]
//                )
//            ),
//            equivalentServing: 0.288624
//        ),
//
//        /// volume-size-size-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                350, .g,
//                food: Food(
//                    serving: .init(0.2, "box"),
//                    density: .init(100, .g, 1, .cupJapanTraditional), /// 180.39 mL
//                    sizes: [
//                        .init(name: "bottle", quantity: 2, value: .init(4, .cupMetric)), /// 250 mL
//                        .init(name: "pack", quantity: 1.5, value: .init(3, "bottle")),
//                        .init(name: "box", quantity: 0.5, value: .init(2, "pack"))
//                    ]
//                )
//            ),
//            equivalentServing: 0.78920625
//        ),
//        
//        /// volumeprefixedsize-based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                1.7, .oz,
//                food: Food(
//                    serving: .init(0.5, "chopped4"),
//                    sizes: [
//                        .init(name: "chopped", volumePrefixExplicitUnit: .cupLatinAmerica,
//                              quantity: 1.5, value: .init(270, .g))
//                    ]
//                )
//            ),
//            equivalentServing: 0.53549111
//        ),
//
//        /// volumeprefixedsize-size based serving
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                14.3, .oz,
//                food: Food(
//                    serving: .init(0.8, "pack"),
//                    sizes: [
//                        .init(name: "chopped", volumePrefixExplicitUnit: .cupLatinAmerica,
//                              quantity: 1.5, value: .init(270, .g)),
//                        .init(name: "pack", quantity: 0.5, value: .init(2, "chopped4")),
//                    ]
//                )
//            ),
//            equivalentServing: 0.70381632
//        ),
    ]
}
