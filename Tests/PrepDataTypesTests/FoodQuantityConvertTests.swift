import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class FoodQuantityConvertTests: XCTestCase {
}

struct FoodQuantityTestCase {
    let quantity: FoodQuantity
    var explicitVolumeUnits: UserExplicitVolumeUnits = .defaultUnits
    var equivalentWeights: [WeightUnit: Double] = [:]
    var equivalentVolumes: [VolumeUnit: Double] = [:]
    var equivalentServing: Double? = nil
}

struct TestCases {
}
