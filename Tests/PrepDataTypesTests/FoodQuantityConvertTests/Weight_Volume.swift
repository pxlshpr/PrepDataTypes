//import XCTest
//@testable import PrepDataTypes
//@testable import SwiftSugar
//
//extension FoodQuantityConvertTests {
//    //MARK: - Weight → Volume
//    func testWeightToVolume() throws {
//        for testCase in TestCases.WeightWithDensity {
//            for (volumeUnit, expectation) in testCase.equivalentVolumes {
//                guard let result = testCase.quantity.convert(
//                    to: .volume(volumeUnit),
//                    with: testCase.explicitVolumeUnits)
//                else {
//                    XCTFail()
//                    return
//                }
//                XCTAssertEqual(
//                    result.value.rounded(toPlaces: 2),
//                    expectation.rounded(toPlaces: 2)
//                )
//            }
//        }
//    }
//}
//
//extension TestCases {
//    static let WeightWithDensity = [
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
//    ]
//}
//
