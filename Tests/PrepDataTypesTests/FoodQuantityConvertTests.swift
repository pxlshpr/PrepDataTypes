import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

struct FoodQuantityTestCase {
    let quantity: FoodQuantity
    var explicitVolumeUnits: UserExplicitVolumeUnits = .defaultUnits
    var equivalentWeights: [WeightUnit: Double] = [:]
    var equivalentVolumes: [VolumeUnit: Double] = [:]
}

struct TestCases {
}
