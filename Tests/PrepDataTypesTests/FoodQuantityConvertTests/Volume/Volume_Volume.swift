import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

extension FoodQuantityConvertTests {
    
    func testVolumeToVolume() throws {
        for testCase in TestCases.Volume {
            for (volumeUnit, expectedVolume) in testCase.equivalentVolumes {
                guard let volume = testCase.quantity.convert(to: .volume(volumeUnit)) else {
                    XCTFail()
                    return
                }
                assertEqual(volume.value, expectedVolume)
            }
        }
    }
}


extension TestCases {
    static let Volume = [
        FoodQuantityTestCase(
            quantity: FoodQuantity(100, .ml, Food()),
            equivalentVolumes: [
                .ml : 100,
                .cupJapanTraditional : 0.55435445,
                .fluidOunceUSCustomary : 3.38180588,
                .pintFlemishPintje : 0.4,
                .tablespoonUS : 6.76132522,
                .tablespoonMetric: 6.66666667
            ]
        ),
        
        FoodQuantityTestCase(
            quantity: FoodQuantity(2.5, .cupJapanTraditional, Food()),
            equivalentVolumes: [
                .ml : 450.975,
                .cupJapanTraditional : 2.5,
                .tablespoonUS : 30.49188641,
            ]
        ),

    ]
}
