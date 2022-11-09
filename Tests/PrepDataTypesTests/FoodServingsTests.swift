import XCTest
@testable import PrepDataTypes
@testable import SwiftSugar

final class FoodServingsTests: XCTestCase {
    
    func testWeight() throws {
        let food = Food(
            serving: .init(0.282192, .oz), /// 8g
            sizes: [
                .init(3, "ball", .init(12, .g)),        /// 4g
                .init(1.5, "box", .init(30, "ball")),   /// 20 balls = 80 g
                .init(5, "carton", .init(15, "box")),   /// 3 boxes = 60 balls = 240g
            ]
        )
        
        let expectations: [String: Double] = [
            "ball": 2,
            "box": 0.1,
            "carton": 0.03333333
        ]
        
        for (sizeId, expectedServings) in expectations {
            guard let servings = food.servings(in: sizeId) else {
                XCTFail()
                return
            }
            assertEqual(servings, expectedServings)
        }
    }
    
    func testVolume() throws {
        let food = Food(
            serving: .init(0.25, .cupJapanTraditional),                         /// 0.25 x 180.39 mL =  45.0975 mL
            sizes: [
                .init(1.5, "bottle", .init(6, .fluidOunceUSNutritionLabeling)), /// 1 bottle =  120 mL
                .init(2, "pack", .init(4, "bottle")),                           /// 1 pack = 240 mL
                .init(0.5, "box", .init(6, "pack")),                            /// 1 box = 2880 mL
            ]
        )
        
        let expectations: [String: Double] = [
            "bottle": 2.66090138,
            "pack": 5.32180276,
            "box": 63.86163313
        ]
        
        for (sizeId, expectedServings) in expectations {
            guard let servings = food.servings(in: sizeId) else {
                XCTFail()
                return
            }
            assertEqual(servings, expectedServings)
        }
    }
    
    func testWeightBasedSize() throws {
        let food = Food(
            serving: .init(2, "ball"),
            sizes: [
                .init(3, "ball", .init(12, .g)),        /// 4g
                .init(1.5, "box", .init(30, "ball")),   /// 20 balls
                .init(5, "carton", .init(15, "box")),   /// 3 boxes = 60 balls
            ]
        )

        let expectations: [String: Double] = [
            "ball": 2,
            "box": 0.1,
            "carton": 0.03333333
        ]

        for (sizeId, expectedServings) in expectations {
            guard let servings = food.servings(in: sizeId) else {
                XCTFail()
                return
            }
            assertEqual(servings, expectedServings)
        }
    }

    /// weight-based-size-based size
    func testWeightBasedSizeBasedSize() throws {
        let food = Food(
            serving: .init(1.5, "box"),
            sizes: [
                .init(3, "ball", .init(12, .g)),        /// 4g
                .init(1.5, "box", .init(30, "ball")),   /// 20 balls
                .init(5, "carton", .init(15, "box")),   /// 3 boxes = 60 balls
            ]
        )

        let expectations: [String: Double] = [
            "ball": 0.03333333,
//            "box": 1.5,
//            "carton": 2
        ]

        for (sizeId, expectedServings) in expectations {
            guard let servings = food.servings(in: sizeId) else {
                XCTFail()
                return
            }
            assertEqual(servings, expectedServings)
        }
    }
    /// volume-prefixed-size-based-size
    
    /// volume-based-size

    /// volume-based-size-based size

    /// serving-based-size based size

    /// serving-based-size-based-size based size

}
