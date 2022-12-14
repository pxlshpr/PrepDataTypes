import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class FoodQuantityConvertTests: XCTestCase {
}

struct FoodQuantityTestCase {
    let quantity: FoodQuantity
    var equivalentWeights: [WeightUnit: Double] = [:]
    var equivalentVolumes: [VolumeExplicitUnit: Double] = [:]
    var equivalentServing: Double? = nil
    var equivalentSizes: [(VolumeExplicitUnit?, String, Double)] = []
}

struct TestCases {
}

func assertEqual(toPlaces places: Int = 2, _ double: Double, _ other: Double) {
    XCTAssertEqual(double.rounded(toPlaces: places), other.rounded(toPlaces: places))
}
