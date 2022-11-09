import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    
    func test_Size_Weight() throws {
        for testCase in TestCases.Size_Weight {
            for (weightUnit, expectedWeight) in testCase.equivalentWeights {
                guard let weight = testCase.quantity.convert(to: .weight(weightUnit)) else {
                    XCTFail()
                    return
                }
                assertEqual(weight.value, expectedWeight)
            }
        }
    }
}

extension TestCases {
    
    static let Size_Weight = [
        
        /// volumeprefixedsize-size based serving
        FoodQuantityTestCase(
            quantity: FoodQuantity(
                1.25, .tablespoonUS, "chopped4", /// 14.79
                Food(
                    sizes: [
                        .init(1.5, .cupUSCustomary, "chopped", .init(270, .g)), /// 236.59
                    ]
                )
            )!,
            equivalentWeights: [
                .g : 14.065471913437
            ]
        ),

//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                amount: 100,
//                unit: .weight(.g),
//                food: Food(density: FoodDensity(100, .g, 1, .cupMetric))
//            ),
//            explicitVolumeUnits: .defaultUnits,
//            equivalentVolumes: [
//                .cup : 1,
//            ]
//        ),
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                amount: 100,
//                unit: .weight(.g),
//                food: Food(density: FoodDensity(100, .g, 1, .cupMetric)) /// 250 ml
//            ),
//            explicitVolumeUnits: UserExplicitVolumeUnits(
//                cup: .cupJapanTraditional,   /// 180.39 ml
//                tablespoon: .tablespoonUS   /// 14.79 ml
//            ),
//            equivalentVolumes: [
//                .cup : 1.38588614,
//                .tablespoon: 16.90331305
//            ]
//        ),
//        FoodQuantityTestCase(
//            quantity: FoodQuantity(
//                amount: 50,
//                unit: .weight(.g),
//                food: Food(density: FoodDensity(100, .g, 1, .cupMetric)) /// 250 ml
//            ),
//            explicitVolumeUnits: UserExplicitVolumeUnits(
//                cup: .cupJapanTraditional,   /// 180.39 ml
//                tablespoon: .tablespoonUS   /// 14.79 ml
//            ),
//            equivalentVolumes: [
//                .cup : 0.69294307,
//                .tablespoon: 8.45165652
//            ]
//        )
//
    ]
}

