import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    
    func test_Size_Size() throws {
        for testCase in TestCases.Size_Size {
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
    
    static let food = Food(
        density: .init(100, .g, 90, .ml),
        sizes: [
            .init(0.5, .cupUSCustomary, "chopped", .init(135, .g)), /// 236.59 mL
            .init(2, .cupUSCustomary, "pureed", .init(600, .g)),    /// 236.59 mL
            .init(1, .cupUSCustomary, "sliced", .init(200, .g)),    /// 236.59 mL
            .init(2, "medium", .init(100, .g)),
            .init(2, "small", .init(75, .g)),
            .init(3, "bottle", .init(200, .ml)),
        ]
    )
    
    static let Size_Size = [
        
        /// volumeprefixedsize (weight-based)
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                1.5, .cupJapanTraditional, "chopped4", /// 180.39 mL
                food
            )!,
            equivalentSizes: [
                (nil, "medium", 6.17591192),
                (.cupUSCustomary, "pureed4", 1.02931865),
                (.tablespoonUS, "pureed4", 16.46561866),
                (nil, "bottle", 4.16874054),
            ]
        ),

//        /// weight-based size
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                1.5, "scoop",
//                Food(
//                    sizes: [
//                        .init(1, "scoop", .init(30.4, .g)),
//                        .init(1, "container", .init(74, "scoop")),
//                    ]
//                )
//            )!,
//            equivalentSizes: [
//                (nil, "container", 0.02027027027027),
//            ]
//        ),
        
//        /// volumeprefixedsize
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                1.25, .tablespoonUS, "chopped4", /// 14.79
//                Food(
//                    sizes: [
//                        .init(1.5, .cupUSCustomary, "chopped", .init(270, .g)), /// 236.59
//                    ]
//                )
//            )!,
//            equivalentWeights: [
//                .g : 14.065471913437,
//                .oz : 0.4961449210774687
//            ]
//        ),
//
//        /// weight-size
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                1, "scoop",
//                Food(
//                    sizes: [
//                        .init(2, "scoop", .init(60.8, .g)),
//                    ]
//                )
//            )!,
//            equivalentWeights: [
//                .g : 30.4,
//                .oz : 1.072328
//            ]
//        ),
    ]
}

